Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6123EC2CE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862389; cv=none; b=eSuIN0uVEFGvbrx27xure+eetHnOyvinCOf4193SAAIcPGNYLRoNxETwOvWdLVak7oaIvHJXESM660B4Y379dJ1gURMsChg/Trg37PIeRQFNQlpG8/HMgCHCWYl4r6fFNnVbSRFRjaicYsNnUxLSHv6cSIXTKZc1O7ZQ1Cu2nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862389; c=relaxed/simple;
	bh=MSNZByR47NedQHBJSJA1SNopobGCivI5HjPYp5UzzVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFOKPTzMu+ls3LfTHIZSNdxtj7QXl30+2T6XPOXBg5F/s+1qcdGfQXj4CgUJoqZCxeK+rHcNPgfWEiTcm5OS2P1jWyWKrfFMTG2Hodkw7/WZAMQk8FuFsCedRFbpSzmbJin+QfAfNmZ9bY4g2ljoz/Q7xmDW9GV1N5MR4DZRaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVEGp4tK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVEGp4tK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso29158325e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862386; x=1777467186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
        b=fVEGp4tKHN3olbBx+KJScJX6SGXO2ZabcO4yJyNkjBtInWd3+Utpot18wH8e9JjNcL
         FAR1PZoUJMhmeDBAqXEQNFAimhiH92lakYYyaVuvxhwLNmSU8HaCMGlnQ1ng8slVSnp9
         HDA/BekEOQPI8lQUJMoSX5rBSaqkUalnENysgvNFSrPeD8Gd128T1hDFGlzc0m2Ap/O1
         ffIyqiaRrS6kZX91nqikooORtYejoK2EMjV4FgvYaYBr6gUJQFH5tuVbjMgAd3HCTa/a
         hgyjxnv7chMnCvuBFi/QB/bmL6sZ4+qEPjjAody6JgdJ+BH+rG/FCYmh9703Gd70cTPR
         ykfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862386; x=1777467186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
        b=d1BIU/xQkYkKG/4w25Mxp4vf2Z2nm4rl7m8+WIdbpmJZSkPoXF8OooSPQKieim3/S7
         4yjVDH9F/no2RjjnHKiyYlmZfSqWwQKbGd3PG5C/MLEghmA/GD3zsVxsvt9kzmKz7A+c
         kaTLCtjOEFJPzlBigzJu+bYhI6BtHOnBj4FAk/a9TRSoAoGCx+yKyAp6iBN951QSrCjm
         d0/nUIFUcenkkTO0rjHIQZbWjF9q2Sgd84BNfaO7RBNbHlUL07qFhKH+WNdqgCKGb7Bg
         cNt7WobZyOzMVi4nnwZ0+JavHeWKu5N0ixcTWqJAUqIuJqRydh6WxB+uXQPTDtVD5ecG
         +K0w==
X-Forwarded-Encrypted: i=1; AFNElJ/ZD3I1oPqMY49BeaZrAnaaD49ynSUwgpL5Gb1abaZJj1Z7eT71cK0Kg5RecTVJHuEbPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocPV38smA5POFHioxcybE3CASDTPcNRKB9FYrcm7fZr5GRbIV
	DEydJzTy5ErqQuqwZykxjOTf2CSwgO1aOYEAcoTVshrF7tVZF0G39XLfaDnihrhU24g=
X-Gm-Gg: AeBDiet39IrGkCEyLdRThQJwAl/tGjgUuRCmSmnQxOYKaZOO5Y5/gKnBxHyTRvc0zto
	WWo8QU28xkVLbjrH2DH3k0jaSKqdmHqQRyFfTkSeIHqeMR+4Yjqcw2GLJSFrKfe1Ciq6zUqbFbC
	1VtULyAaGAs78XzEatOMKjAGdkA5HRJmam0ZwrCukIwyALMnhTJUqq9pwfOxZBjBjmGCRL2PAtw
	7CK3swYSjC7/LSzkkt6EJZelCQXPXULkDWPSNHzZe79SbKGWDE8AzP8KjKAjFItismSXrhhd9lg
	lhjjXhyaIVblxCSF6vIsd3A9J3R/aDCZvDj8aF6jmr1n12V1u2moHx3D2CG1sT+mgb89zkJ/fWE
	s1pUryvS1eGYWWhsuW4ApoHL4C/r+gYeXPxg3qolBmw9jcVOPXuWpipTZoYfEpeFvockP8KGQtg
	BrgV6/5Kt4A+qVHidcgJ8Bbasi4qlxTdiGRg==
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-4891ae14f23mr179317695e9.28.1776862386147;
        Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm162310925e9.13.2026.04.22.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8B960612AD;
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
Subject: [PATCH v3 20/32] target/arm: use syndrome helpers in merge_syn_data_abort
Date: Wed, 22 Apr 2026 13:52:37 +0100
Message-ID: <20260422125250.1303100-21-alex.bennee@linaro.org>
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

One more step to removing the old defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f9..c74d8e785a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.47.3

