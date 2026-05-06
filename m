Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D0344DBB;
	Wed,  6 May 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084082; cv=none; b=TSPGnN0PJHvXMZUjOksRXhFVVheXlo+sZVa/vhnSv2zP1pEBMXMPjKERTSGAuzjO5qbJeJiopJEHYKjFzO/8eoRQXTSstl0FCU6iazkwnQMqAiTZZtynBQa3DvtvbUFTeRriQZZcTE2q98Sy+Uc2dkRtVUF1UqC+TY0DeBv5vHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084082; c=relaxed/simple;
	bh=ciZSpYmeDVVxNWQn/UOTdNqEuasWoUdbPOgK8ZRpbmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFbg2jHimJRfKQfSgxl0oD2xGDA3sudypyFPN3k7uQC2UwoCQh8gDUjtZtnbe2RhgSym1BCCDldvjHlizuuosQFRrN8ON89YLSM0n9Jv3EQIig3jDMtRSVLBfNPd9n4ITb/rqx9n0oMKkmR60D/m7tQ0iHnwP8x/KlTYggxYaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSD24bxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSD24bxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ECEC2BCB8;
	Wed,  6 May 2026 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084081;
	bh=ciZSpYmeDVVxNWQn/UOTdNqEuasWoUdbPOgK8ZRpbmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSD24bxU1Mw3yYP+rar04tJ4Amj4VFiTV5bEcMPSLcmh37rBWP96wLN4HuW1dpyej
	 Tk4SHRP+Uti17oX3Gw+8W1LxmQAS5vQiTDB4XIcjf4LbmW7g4Wfsp63/pkwXIgiQyX
	 X1qsvoT0Qc8I3Gp6zbokb5UjN/R7NwwpU+I1qYlT1th76sA5dJd00V/F4mhbmCaegV
	 fSF8JeGarqUZJArtKk5mwTUrG07dSUhyGvtgqVsy0pgMEvKP1kUMiXyoWYiWnEX+AE
	 Pfn2E2zdLiZwoDXW3i9BK0YNwekbjchaKSMCxPIz78lb4teNWTdIL7tNnYv8AM9Y1V
	 /TMW0zbFlRzfA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKetT-00000000MIF-1b7U;
	Wed, 06 May 2026 16:14:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvmarm@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Oliver Upton <oupton@kernel.org>
Subject: Re: [PATCH] KVM: selftests: fix steal_time for arm64
Date: Wed,  6 May 2026 17:14:36 +0100
Message-ID: <177808404897.2712489.1592501636767693366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504112808.21276-1-sebott@redhat.com>
References: <20260504112808.21276-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: xujiakai2025@iscas.ac.cn, shuah@kernel.org, andrew.jones@oss.qualcomm.com, anup@brainfault.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, kvmarm@vger.kernel.org, sebott@redhat.com, pbonzini@redhat.com, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 04 May 2026 13:28:08 +0200, Sebastian Ott wrote:
> Fix the following failure to the steal_time test on arm64 by making
> the timer address known to the guest.
> 
> ==== Test Assertion Failure ====
>   steal_time.c:229: !ret
>   pid=18514 tid=18514 errno=22 - Invalid argument
>      1  0x000000000040252f: check_steal_time_uapi at steal_time.c:229 (discriminator 20)
>      2   (inlined by) main at steal_time.c:537 (discriminator 20)
>      3  0x0000ffffa23d621b: ?? ??:0
>      4  0x0000ffffa23d62fb: ?? ??:0
>      5  0x0000000000402b6f: _start at ??:?
>   KVM_SET_DEVICE_ATTR failed, rc: -1 errno: 22 (Invalid argument)
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: selftests: fix steal_time for arm64
      commit: fc240715fc5003538ff530e3cfb985e7769b7171

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


