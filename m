Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D386385D71
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475845; cv=none; b=nnQDG0qyDcraxvZbixcEPAaQKMPi1NLmcs/FkNp4excDC1Na8M6C4S3RuPNXUty3UtOHw9MkX+q/Gu3KJUk6sWw0SImxYz+m6c0oeEHyi+cPx1zDb/jrY9Fd7P+oS0NP01Q5LLF1jYPt8RKqgIxMBmmG2JRzXe9obpwljIXEV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475845; c=relaxed/simple;
	bh=jLHweH5pCJDxYl5vedtHRjo8da+rVoamNZYaO2qNeH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsjvgyhF2W4vrP6L2WQxAl7AVoFkMILNAMlsunm0YonrfFdNMEyflZ1U6l2FK/C8VS8hBfIZ9SAsiMq0k/OzczCUG7pcF76czmcb0PY60gh3IiZaq8Fy3Ylp7BvcNLUDBt+FatktMVEcdsV+okICxNbGDtGR/z1wcnoTcKXUvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com; spf=pass smtp.mailfrom=mailo.com; dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b=Qw4w4t9Z; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b="Qw4w4t9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
	t=1780471869; bh=77GOEmZV9qaEqRp03oAIJg97fniuxkfCRBHGFUAen9M=;
	h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Qw4w4t9Zk+lG/pr1zAC0lHy9cfEAWmOcyEu1W6EN0n8ORoo4UNZTjg/nw8lHhKWB9
	 mHvJ83iMVeFQghuVpg/pV4ZZlTdpNCd4BLa2BPNQWfhSb08xUf31vQqpmCiHaujtbD
	 7KOgewM//kGskwTQNnvF2TCEbtKVrOtoh8P2pDwo=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Wed,  3 Jun 2026 09:30:56 +0200 (CEST)
X-EA-Auth: ciTW0JDk+KV2s118KBL7MiWzJ1uqpOdFxkmc58zf1K3oGiDW7yPJWKjdVpm4xCgZpd+qbW/CyA378BUgPXknY2wNuHo7qmMX
Message-ID: <00a44006-91ea-44d9-a43c-ba37f4dbcf1f@mailo.com>
Date: Wed, 3 Jun 2026 09:30:55 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/38] MAINTAINERS: Drop stale F: from "Overall KVM
 CPUs"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603064032.3733394-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/26 08:39, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we moved the only file out of
> include/hw/kvm/.  Its new location is covered by "X86 TCG CPUs".  Drop
> the stale line.
> 
> Fixes: a09ef8ff0a (hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h', 2023-06-20)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

