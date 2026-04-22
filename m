Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009F3E9F7B
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862959; cv=none; b=PbJ4KbH68yHna1C/y4HtpbCq/X0GXL3QrALDlqRbXHG024AcfJoP8UE2bARfeZRTYBLIftFNDeINvMgGvdIdJ6OUTl7AhqzDIyLhiOCrYWRZ848yU2CMSpsEk4oUE4UQTWizNBm3i+CTSFMPaueOxyPK99hewrOacN0hDYjFkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862959; c=relaxed/simple;
	bh=lyULEi3e+kfDY4pAOD/6uauE8RXFENVITu7ezFzC9Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dniuxaIJ38feJJBAryPIFoH3PH1dEVtL/v3JSH3KJ1tVzNHqD0eS46pf1ljQ7c+DO4zHiXa474yPkoOSlmrLxT47QapeS9b1kgKZhy6vWBa5nX197mTsckSRkpSxXaLqkC6xl8VN2/DE5ZIQJrjw1HyTY583g69TGJ372VgIHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHszLHWW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHszLHWW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso21253215e9.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862956; x=1777467756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
        b=AHszLHWWF0fO6giJqXYnmfqeqLJJHf1k7VvruOnWlVhkyP5lMVBVn1fimEZIyu5ioA
         kYEPE5OjDvXMVJTwe1R8niXcwaev+ecAqWcRddprVRKK/j+bgts8gn7FBhnJTvCkl0ZN
         0KI7gMD2P+qN0+MjGFsnYt7fKryQzzxEf+EeUYJdsPilsgeGt5Rm02I5AQ6kQGiNAVRe
         f45w7NSiSia1FGCSHfCU3BHckflg1FGxkoTqIPMLMJwJ8GW4099Dy3N9bFQ3FFq0k/zX
         GVRJeGT7Fy1D36tqhPnh657ZVbQQ5fqONGIwFGaJzIL5ME8pV+9pxtjw475c5G5oxTHU
         JsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862956; x=1777467756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
        b=FC4Q7mKIRIHi66th/HA+0rDIFExSu/pqIhOHyuOOT0JJfAkOMOlV8y9zhPvw8+viGy
         +ITFsZgkmF+olSWwsPD7alFgi0ePE8vWBb0XtHzwPRNn2SvoL9YncFx/zENL6XFxEv6D
         AslafPHwAQ/tY2sETGppAomRaPkoGMbTpJ0OYEIlorDsnP8RdBJKi4w9DWLJjASudvcz
         wVm4Hv567XKATPzMq2NF0EAOGgKBPk8p6qtCZzjKAgDgulNfSy91qB/p1EDZPGt5vB/c
         jIuXnkqWGmL40lfQCHMliTcjtbptLkgRc5rmjSMPr2qU4dORORWxbDgX+pPjGURq++bE
         MQoA==
X-Forwarded-Encrypted: i=1; AFNElJ8rKEClxmKm5O7uQZknNdIdaS6VuNjRCPZHN42IiCWqXFmWtbOwlay4dRRmc5+ILAYYn2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WlXeR7uTt1Z+1FZZZss0Je8zBiwJfo8VyRK3cb9gumH+Re0e
	poQ1UftZMeiCMlrHxKVcFcNhT1kEBfaiu9O1a5JNn2fcTDuQz6t9ynDeheSSV+BoYag=
X-Gm-Gg: AeBDieuofFyXsPyyJU+0H2CB4wOFYi8aA6piBg4WIY7GDDe+CDKcHjWaPhSRrjCLHjR
	fIqlgbX/N4cdU9D0jjRU8uQck/AYXyPAD2XpQBGr6rvNhW3WilebEqyMNhed6KI34YtKkedgICM
	QpdqItg74/E/Z+Lrqsofs53JpwsQwUdf7r4hvM0VFUdOrLyjAsPYu2uhuA4z5Np1146HfBQU0tQ
	+Hq9XH446jR+k/niIDvRD3VcKDHqMhf9XaA7eEb9V96eGhUQE+CHaOa85AkL/t2c3eohyWxJz3y
	0xWBKYrbuxbPXAVDRSyToAhXH+8hB257IXjiuwFvLUoDAaRat0w0OaPC6/saC4lbLlAEMGXrEub
	YCqB3gWkdfDkS3rmZduyTRq2oRWEikQ9TbW4TrVO5YQEPsixsT52TT3Z+ZZ0M3zl1TpFgDuNoSi
	RcynZgc3S/x/TFWFsrGL+/Sw3On7Uls3iG8g==
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-488fb745294mr205580125e9.1.1776862956044;
        Wed, 22 Apr 2026 06:02:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm550412285e9.4.2026.04.22.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B2A04614A7;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 22/32] target/arm: remove old syndrome defines
Date: Wed, 22 Apr 2026 13:52:39 +0100
Message-ID: <20260422125250.1303100-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now everything is defined with registerfields we can drop the old
defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - remove stuff dropped earlier
---
 target/arm/syndrome.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d4dfab8cd15..04a71eebcb5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,15 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.47.3

