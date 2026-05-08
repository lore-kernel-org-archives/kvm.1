Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F6379EC6
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264235; cv=none; b=NmzASNm/HLzZUN0vQJMcPiKgyofj94sKfwLaisNvsuMVPL+PYpcdJb5FsBeWQ10XCWHHvuDZbIdnD/cIjdSHaLXDFgWi9w7Ncf1LzzTwPRw39+tIej5mxuKNT1dWdx3jFOaD0XfeFJttfR8TM2L35CteY9FeEyKvyERte6P4oMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264235; c=relaxed/simple;
	bh=tVeBTBMarQaA7cDl8Bnbve0BHEZ1LCYSi6e8kRgFrps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HtPkH66U8WvdIJV1YbFELtPWzPo9qYc+VKmkIcIddg0dVz4/mbwUcyPN8aNtrnd7Rj2aTfJTQYxLiKT+vK7HK4CNg13Z0j0Mg++G5EmORCXcAIZtBb5Al0K7BDTlymfzOhLUs4ClEdCaPk2EQkzcIps1YDZcL8Lgxb4zlQRI94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByyA0tI3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByyA0tI3"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8252a49ffcso2739522a12.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778264233; x=1778869033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCYkJG0gtD5JkM6uE8YeEJnNDMm/eOHj+QJQbAMo/F4=;
        b=ByyA0tI3clBP/mi87f9242Wd4ba9+Cy8j0tyqgoJ3QFDFT4s+S/b9JHl0iWO1GYizZ
         VFocPKt0gtF9xLhwmpbKjaOHZXu4rXayzWsfqYdIgRUim4cBPd+52BgO2PGlCnOqiYYX
         zW1fsSTjMZOC9IS+l/FJsDAKjWRxIlx50utZu5moLG9UMFq0hB1TV1xyjszRmt5ZBWI7
         OTQeYucNdBtJD8GAcFsobuPeXoY8Ep+J05o3QKxWmSoBpbhvLTXXpikZX8eojsjtwtP6
         Qjra3T4Ea9kSfzFlU/ZzzAlbT8kzdC7JOO/4U6NpV0/ASR/Em6Ilk/9IDFykePwcMsGA
         Idjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264233; x=1778869033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCYkJG0gtD5JkM6uE8YeEJnNDMm/eOHj+QJQbAMo/F4=;
        b=OqDegbt/cgUxAF7uNcNIp3UKA0aTWJWd6bd23UCGwLK2tF3JpsH87hPRzNc935ssvx
         Y2fErRXE6mUGA8+bXeN2dha+oe6NwEF1seVjlXZEZrWk8FdzT9WGl2dj849oQJkekIhT
         igd414qXZvanAndMwsF7m15OPLtiv4sFcMB5+eXINOa34sM+qOUwTbhUp6iMBcTgs6El
         kNDKlX3wxE9XBV9I98QRDlgazziGA4uuGvVJz2JuH+W3S86IrNhlIVPDmRxyE6qefe/e
         RKppinMWrSHjehSRa48GrA8exM/aFGfTv5gAtRVrW9/qKsoz8M+kAOzXqyqgHqeHl8x7
         hsBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ixOISpWAyHJVoefXO7kg10xI8//VBj8jpDY+UdtAjIvQAdXH+rkdcla09OqQn1qWa+8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeiDLV/ES1/5rQ8n6EQOA3qf4HP/61yoqUGvTq+Xy3uApaW5d
	YNFskq5axcNjZfWW3LnE5Ewo+8rBxtXd98U8TA0smuThpwoYPVso5OiwfIw21/PbA/SBMD5D4SM
	MOKz8xQ==
X-Received: from pgno26.prod.google.com ([2002:a63:7e5a:0:b0:c81:2646:5294])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:39b:d937:8010
 with SMTP id adf61e73a8af0-3aa5ac011e5mr14816254637.45.1778264233154; Fri, 08
 May 2026 11:17:13 -0700 (PDT)
Date: Fri, 8 May 2026 11:17:12 -0700
In-Reply-To: <20260414230943.41198-2-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com> <20260414230943.41198-2-jrhilke@google.com>
Message-ID: <af4oqOB-zXgVgkLf@google.com>
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Josh Hilke wrote:
> +# Print the segment:bus:device.function numbers of PCI devices that can be used
> +# to run VFIO selftests.
> +function main() {
> +	local vendor_device_id
> +
> +	for vendor_device_id in "${DEVICES[@]}"; do
> +		lspci -D -d "${vendor_device_id}" | awk '{print $1}'

For ignorant people like me, it would be helpful to capture what device was actually
found.  I mean, I don't necessarily know exactly what these devices do, but as the
list grows, at least having a general sense of what device I'm going to be feeding
into VFIO would be helpful.

E.g. something like this (ignore my terrible script skills)?

#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later

# List of devices which have a VFIO selftest driver
DEVICES=(
	"8086:0b25","Intel SPR DSA"
	"8086:11fb","Intel GNR-D DSA"
	"8086:1212","Intel DR DSA"
	"8086:0cf8","Intel CBDMA"
)

# Print the segment:bus:device.function numbers of PCI devices that can be used
# to run VFIO selftests.
function main() {
	local found
	local i 

	OLDIFS=$IFS
	IFS=','

	for i in "${DEVICES[@]}"; do
		set -- $i
		found=$(lspci -D -d "$1" | cut -f 1 -d ' ')
		if [[ -n $found ]]; then
			echo "$2 ($1) Device IDs:"
			echo $found
		fi
	done

	IFS=$OLDIFS
}

main


# ./devices.sh 
Intel SPR DSA (8086:0b25) Device IDs:
0000:6a:01.0
0000:6f:01.0
0000:74:01.0
0000:79:01.0
0000:e7:01.0
0000:ec:01.0
0000:f1:01.0
0000:f6:01.0


> +	done
> +}
> +
> +main "$@"

Why pass along args?  The script doesn't actually recognize any arguments.

> -- 
> 2.54.0.rc0.605.g598a273b03-goog
> 
