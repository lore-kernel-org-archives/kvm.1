Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642101;
	b=ubUFmGNPMJWpKECLMiWuJdaFZVKvtmvuCCeXBt9MemdNEd2E2V3dJ3a22vB1kpEt+Ty3
	 rEeQHf5oEXDvUnB5bYkC4MN00hnNTVQq/YvH2f41fkm7U54AQlRcPchaQCM4BKajeXQGp
	 ZoDyOPa09H6Az9cutr9VXByDssCsPVF6BRKq2a6isrmVCngsEpPS2Aw7RrXn7VvSXBdsg
	 DvyUywb+9JmVJAwCS0G2N3zvbOgV+hNIavW+gsn7+ii3KtK35C6SF7iZOrZVL4GHJFXiC
	 ECvlkCQeVNplw8+C8cNKTODXAWwKOldFXowrTW+WO9WxUCGjKFnGfQIQXiblDGtYc2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
	b=y2Ruib9aQx9qj7Q7MV97YrXucNmojBxMV4dX9JEEMDtW8IpQoqodLKjlRfjy4zWkb31V
	 q3HYNMg9DWvhiqmqLmpNv3u0J0hgVVdJdmeGSzZqKguKRvU570cZK8f4Z/tvw0FoDhaUN
	 UuBMX0cVyj9+ZK/h1h8kihecbUpIanmw6KWyntt1hzO9oZtDoHPF/PlNwnMzMQUJ5wqVF
	 lXZc5fpjrhAH0K3qgFYDI5Cv5yTRZ2aTEgiIb3f4EI/0Trlnwj3K8IhdBGx/+90kIJI7F
	 FoW8ER62x1X2JafETEnVcVbiW84Pm0IKGVp8y1UDGJV/Qks7CrRs9bIipnsMMKDQz4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BIrDgVS2;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C4606A329
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60C4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BIrDgVS2
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd65070d3feso1947668a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793642100; x=1794246900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
        b=BIrDgVS2z3qzeQ5pQ9I0pkMVnSSs0kJP9FikYmDOjk06hi8F2fPQhmScTZLO8L0cWw
         gFOZBG+8fjryAVdYL9Kb6Iodfp6dzzbEmoYHWsXO4RuMayVLbEdpu7n24yXahK+CdH/M
         zkxM3jjnKKMDEdiZLa0dq3TzRM8R8fi9WpalpJznZ8vjNrchHYu/fVg1CXxkKI3ReeDU
         Z7HjomKzwm1J2I4ZTS0tR9I01uAQK0SCHfwnG3YwTxFMMakluHg9GkHKwNFybZgAmWRz
         quSSdtKHvknwDRVRGsSz02E3xVggKpyR7+GACSqx16g4vwPX14MSicxrX/JszWiyh9gp
         hs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642100; x=1794246900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4l9yfaXeZlkaGd151Z0zPjN7E7u16Al8j7C9HAa63o=;
        b=it9ulzhGQJQIKLo1Tlrd4MTL6b8w1u6gjwt3kAtGURsTTQrjA77HlMpjakk2kgLC3o
         JU9OP9rP2X+9+6M1OSe9tiThz6ON3VL9YbAV293dtsmOcN4voXUvN7HQBfHUBnAt7koq
         4QBOUpzLh7RVciLmZxLvI9ABVVhivCSLmJpfekAchmDV+7N8gkfVcLLFa1i9M5Tu3UuG
         /O+s1HO9QMp3ar7wTT/kdFBIIUSCRNGc4elGAN/zhKr4OG+zHG6GZOAr9ZDNzAo6XV/B
         Th5FdCOsNIqrHgj3ho2+HoMnBvSJewvMxEXyvCWIreUtikzekwt7oDaqDe4kFehb4cD5
         GTMA==
X-Forwarded-Encrypted: i=1; AKwUvBy+xmcYAy4Mup6pp0VSis+EcPCT3gR4nQby0CR5rAk+lU3iYtGLnptFtpjhEFLRdsbc3TQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OgMKZv1RgkO6VlXxtD587YSagqRNvQJobb6yAw2m4sKnz2CCW
	enaGxQyajlGFPpBCCcHrdI8HkJ1RzPk4M9Mn7J/fKi25wOhdWzgziUkFPYlbmHK7rDmTtdeJBQk
	UVkfjbg==
X-Received: from pjbfh11.prod.google.com ([2002:a17:90b:34b:b0:3a9:ccc3:cbae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4c:b0:3a4:7195:ecba
 with SMTP id 98e67ed59e1d1-3ae8972d1d8mr4920521a91.20.1793642099792; Mon, 02
 Nov 2026 09:54:59 -0800 (PST)
Date: Mon, 2 Nov 2026 09:54:59 -0800
In-Reply-To: <2026-10-30-1-daily-reply-0006-kvm-nested-ept-gva-6-12@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103713.573783-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0006-kvm-nested-ept-gva-6-12@kernel.org>
Message-ID: <aujOc5ybL-lZEW8v@google.com>
Subject: Re: [PATCH 6.12.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sasha Levin wrote:
> > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.12.y, with its two
> > dependencies.
> 
> Same as for the 6.18.y series: KVM x86 opts out of stable by default
> (Documentation/process/maintainer-kvm-x86.rst), and none of the three commits
> carries Cc: stable or a Fixes: tag.
> 
> Bjoern, could you get Sean or Paolo to ack this series (and the matching
> 6.18.y one) on the thread? I will pick both up once they have.

Acked-by: Sean Christopherson <seanjc@google.com>
