Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A729A32D
	for <kvm@vger.kernel.org>; Thu, 12 Feb 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930520; cv=none; b=sXlW5tYzGXsxLvuemZPsGy8BXsAR4+83Zk28dvLZ5cL8CNqYBu0rSyESLkULyDyuEededrkw9UjABZUlLeZDdEgEQUJRgqOuxiA7cGj/uU7J8LAoBAXJfNCBIVid6QiLvC3nUnQ3cN7Xr8IS1Vadf5RHSqH0wf+9HOGWZnLiUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930520; c=relaxed/simple;
	bh=Si4a3lubEVIsFr5xg//zf0cPvmnb0GNinNu5h5MauAE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=DGj+YT9ZbGw1yNI5cNSx15z+A95HVXkADzkTsPDhe2BPKrg59tNGztwWWNlks27euaVfZ+DeD4k/DxsOPDWRSOIkOjXjU1+SFQKCwc1DOGfxHMQDDULaHS3iPW0xvLzpcMN7gUUMIOkvREVWXQbFVOXxfy1q+uW4ZuKU/J3Etxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8jy3zsw; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8jy3zsw"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-676de68a609so1989743eaf.0
        for <kvm@vger.kernel.org>; Thu, 12 Feb 2026 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770930518; x=1771535318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DEi6lE69DtAre9+98et1Td5y86Gv96d2+RPCeTq+27M=;
        b=f8jy3zsw9Uhk0b4rInPMiIs/KIJkcZftveWo2R13oY5ZXtqJoVJZKhiYEPY/PzrFzr
         mpCP0oOH9McaaBPWnQyEGSqZLIs47USxQ5YmisJIjhA5xl/cXYd7krqkBh1h6BWqk/gY
         EoiZIuUnBCzmJmrlmECggq37K3gNx+6mbmCqHLWVeCri9A7STJDwzVovNcnMG5KBoiNt
         wlj8rrJ9h7bFf3Cow96e3Voems+MqtAm5rjlVWu9fmRAnvzIMRK4TlvkKl68BmVNYIG6
         uhw3Mw4o+HOsOgeTRuu067BqT9eBnV5WK0CeqSH7vIt5vMEOQKnzzVO0qsErxTxKkAXF
         eH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930518; x=1771535318;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEi6lE69DtAre9+98et1Td5y86Gv96d2+RPCeTq+27M=;
        b=Db3DU369X+dAkGEmBoDql0t2t4THasZ9sRcXz7Lvqldy3jdmRSxvV1fdMHE0LqL8AQ
         fwushKZdkoH9Bp7OthkoEURJQNeeUro0wkOF94RQ2G8QCkFFpoC6IVRqkNNzi63+KkmX
         0SHv1iQ51NZJXtTBBy0uVqt6k1piBRHiGtsHD9OOZLfNf3rHopTR078IOE5so8rGi1L+
         o+nFSnTa3JQVY5m9P+0vnrGRzlo3thdWuYmT7kKA6gEsWIoYh5MONJOLo8eAHjyAh845
         qQfWA7uUHft2Q6v66oOq3zof2ZxDAbb4fChvGMvwMOSEvsdN2QRGh8BVUTiFDK3wscx+
         FLCQ==
X-Gm-Message-State: AOJu0YykqyE2Bhti8KTXt7E3nlM4ycaUPP6JSh+9ml+SdnAJxXZXH+wj
	7uOOGyBERbbWn5Xxn9jBBiqjUV2B7FHzfPJXBtAgRFy803o9z4EpwXfN0U3Wn8TjBBXNVFv8oEU
	NxVvaIXvTEcdOXK/XqFLbeul7Ug==
X-Received: from ilmv6.prod.google.com ([2002:a92:c6c6:0:b0:468:4e21:6fcf])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:61d:b0:663:2b12:14f1 with SMTP id 006d021491bc7-677243b521amr65721eaf.83.1770930517469;
 Thu, 12 Feb 2026 13:08:37 -0800 (PST)
Date: Thu, 12 Feb 2026 21:08:36 +0000
In-Reply-To: <86v7g5asp4.wl-maz@kernel.org> (message from Marc Zyngier on Tue,
 10 Feb 2026 08:49:59 +0000)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt8qcxhdpn.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v6 00/19] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hey Marc, thanks for the review.

Marc Zyngier <maz@kernel.org> writes:

> On Mon, 09 Feb 2026 22:13:55 +0000,
> Colton Lewis <coltonlewis@google.com> wrote:

>> This series creates a new PMU scheme on ARM, a partitioned PMU that
>> allows reserving a subset of counters for more direct guest access,
>> significantly reducing overhead. More details, including performance
>> benchmarks, can be read in the v1 cover letter linked below.

>> An overview of what this series accomplishes was presented at KVM
>> Forum 2025. Slides [1] and video [2] are linked below.

>> IMPORTANT: This iteration does not yet implement the dynamic counter
>> reservation approach suggested by Will Deacon in January [3]. I am
>> working on it, but wanted to send this version first to keep momentum
>> going and ensure I've addressed all issues besides that.

> [...]

> As I have asked before, this is missing an example of how userspace is
> going to use this. Without it, it is impossible to correctly review
> this series.

> Please consider this as a blocker.

Understood. I remember you asking for a QEMU patch specifically.

I had hoped that the use in the selftest was sufficient to show how to
use the uAPI. If not, I can send out an example QEMU patch to the QEMU
ARM mailing list.

> Thanks,

> 	M.

> --
> Without deviation from the norm, progress is not possible.
