Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413591;
	b=sAMXR+23yCCYaz/5VWaCkHgI6tEpU7Lrg/Sl/oAZdXbFYaaYecUhcgCsb45QKiWP5J3M
	 NLJNmDEqn69mVgrlCFKUoCpWXqQOgFtpkG5JEsKvinB/zPmPwBFVuLtYCqi4djF3mquEN
	 QwP7kyFhgQI2E94OFXoQpi45s4Vjgq7cni9yJz59SsQ0/1bRc/sh7ROmb0OJ+pfaD4yS3
	 arYwSgW4wXCZzMe+fwb91ePXzBTugl1KQ9leXyIwxQP5V64HcRdZj8W++lKZe5zNagPtp
	 ZEarXdY0gA7baBzF5Nt+v51YMZ7Kwht0QSxzy1sLe7DhLzRiWSimnKYngtqf/nxZrJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uMPpqnKOCd8SQZ0mxTY4mAHckZUWiQiuXf2+p0RRB1c=;
	b=4odYTn30kUyp49IYcD/x9XoxvfpVRiKy1U03wLh62FR2Zx0QR/jVjE2JzcOnytTCv6iB
	 L7+I2H7nrg99No+Y/WUwHrB0HS5095g7WiDDJwqspfkX7UjNdl3COwzOxNWRTGxtIs18c
	 +FlFU5lgUXlnAiTVrKNCuxiEpEG6RgtkCz0XD6tTz6k3JtVaUE8Hwq5rNdzTRlMlkFyCb
	 NiWZizvOKV7J8DfxrmYbpNLGeXdvLrjn/wXnMrVPO6YBEgZ+bYbLe+HHbvU/mHxOYkEFX
	 e40LdyPONeHoACvuP7sTKJBHdXYWmEc8KXdNlXVRxk0VvzZEQ6yx9ASXWy/xzCpgPYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jSGGMQCc;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE22606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE22606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jSGGMQCc
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed08b07232so31025435ad.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794413590; x=1795018390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMPpqnKOCd8SQZ0mxTY4mAHckZUWiQiuXf2+p0RRB1c=;
        b=jSGGMQCcbRPx5uD3f8UO8a4cNFzDl4+F5yNuTf1/gwdXT/OMn1GjPexJYX7Yao29qw
         SRlTTmwcB1Z1AdhUf/OJmschqii9g4CS+4nPUmeQF94GynnWOopR/u0pDutvkXCnX2Ev
         tJ0ZF1ESVOm7P4l+/O+QZenGIWRE7PKTT/FRUR8bHs8KYfsJ9ExVHoaYTpViPivZAqTO
         zMbd690mR2fCEJ6BWxBqCjtKbXqhk5EJ+ghJrlUH4lIh8DizPdKaOy9qYtkW5S1LjzcZ
         rxqJBET7TdAkcujzsr70lGqinpUHbinJz2OZIciEBxdBIHnd7/QfXIJRoe8uQ9RrxlN0
         Ukog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413590; x=1795018390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMPpqnKOCd8SQZ0mxTY4mAHckZUWiQiuXf2+p0RRB1c=;
        b=bqFf7oQbc5GI+QvHASkm7CxEHZVIf3FrFZcVet1xii9ZLJbWMTt6PNmiQwIMGosYRP
         /OwnaD83RdRzfS245EWIgpJIsicxsyWtfqeI3FvTRDWdpPiLxEdRe+k632qvrObw2+5e
         iYstDQ/0I/V/y42fEbEr2AWXpG0l8W+n76jSrSIoNS/wEOMh5LVLCuuqyW2O+Ustso0E
         KYB3f0nzqracoMUu9iKyWH7ghuK45rBedbckqdGjXez/+MrN9mhv5ueqmqK9B4Rlnaa6
         I+Jl8wIMizF0bz0OjMr9y8ouExV2zqK6TpDxNg9+5iFGYLRRzUTU/0Goa0tjo/iiSMWm
         S3SA==
X-Forwarded-Encrypted: i=1; AL+hErH9sqzW439Einc4c83yF0wWMA7xMYFlJPdkKRiRRkXmA5Erpxih+KUA5zdV3g0ZLk6XVWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8+nAJrdwK6WUCK/zs/ahIQj1on0XSdmDAwp/3S0N5YhGJ8dPj
	Hswu+lr+fMbXV7SrbOlqwNIIQjxXe5U2JjwPrwOwCxEcJVV7Isr1sNYWXlOPgCHcj58omTpm1Oc
	+d6q60w==
X-Received: from plsd20.prod.google.com ([2002:a17:902:b714:b0:2ea:1d0b:962c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26ce:b0:2ed:2d5b:d42
 with SMTP id d9443c01a7336-2edd7a91c9bmr31261715ad.52.1794413589808; Wed, 11
 Nov 2026 08:13:09 -0800 (PST)
Date: Wed, 11 Nov 2026 08:13:08 -0800
In-Reply-To: <20261111015446.20577-1-flyingpeng@tencent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111015446.20577-1-flyingpeng@tencent.com>
Message-ID: <avSUFJEEubkNldb8@seanjc-mac.roam.internal>
Subject: Re: [PATCH] KVM: Add Kconfig to compile out the halt-polling histograms
From: Sean Christopherson <seanjc@google.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Peng Hao wrote:
> The halt_poll_success_hist, halt_poll_fail_hist and halt_wait_hist
> histograms in struct kvm_vcpu_stat_generic take 768 bytes in every vCPU.
> Add CONFIG_KVM_HALT_POLL_HISTOGRAMS (default y) so that they can be
> compiled out.

I'm not a huge fan of adding Kconfigs for stats.  I worry that we'll end up with
a mess of Kconfigs that only a few companies in the world can actually use.

I do 100% agree that the histograms are dead weight for many setups, I just don't
like the idea of using user-visible Kconfigs to deal with stats.  And whatever we
do, I'd like to have a plan for stats in general, i.e. not just fix one-off things,
but come up with a long-term plan for how we want to handle stats in upstream (this
isn't the first time memory usage related to stats has come up).
