module Lib
  ( fromClockfyToCassi,
  )
where

project:client:description:task:user:email:tags:billable:startDate:startTime:endDate:endTime:durationH:durationDecimal:billablerate:billableAmount:_ = [0 ..]

fromClockfyToCassi = map formatData . filter (not . hasBeenMarked)
  where
    hasBeenMarked x = x !! billable == "Yes"

    formatData x =
      [ formatProject (x !! project),
        x !! tags,
        x !! description,
        "LUIGI MINARDI FERREIRA MAIA",
        formatDateTime (x !! startDate) (x !! startTime),
        formatDateTime (x !! endDate) (x !! endTime),
        x !! durationH,
        "DIÁRIA",
        "CONCLUÍDA"
      ]
      where
        formatProject = takeWhile (/= ' ')

        formatDateTime date time = date ++ " " ++ time