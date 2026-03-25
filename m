Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97C3EFD3D
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451869; cv=none; b=VAkujb4rY0QnxuaLAKQCbYxS03s5syaCMMUwGV4NEFqpSlC7JpA9tNCUpzOohwRzlx3nAbZyXFPzmAOmpRMhNFj1I/yJP5KnjvJJ1w5XWFTlVWC8ltNvPrWi/53dCb75FKuxk6AVoX/HrjSQsS9EQDhUDP7mpuoZZvB+H2bhcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451869; c=relaxed/simple;
	bh=8rwdm+ow/p/LjQ3n9H4+5XIFIuIxCl60EfR0VkZ6iiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFchp+NiPjYNBFR5Zo5wA80MIMGDPS7JDRnkOdMlZh/Kr2WM1ulQO3MnMGrBLMTqNLPSH+nhS66s4PWrZcgsPEBIAhvQ/1P3nvTbbowFZHQUOCiwXoNVAZ1kxdbgwvx00K6GFT6sbu6/Hcj4WylMdUTX5baYW8RTBHWrrxsoztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u1MZb2HB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1MZb2HB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b87970468so1330989f8f.3
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451867; x=1775056667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGrRVHKmEX4IQk7MCycV3cbvFt2/hR4jH0QSvJAAcyQ=;
        b=u1MZb2HBGrS+EKhtaX09S0yI6UXI04STwZhGBwWRhA46OZ4uHmEm5N1ID61t3ypsHq
         dnwE1/eSRrSsY3P1Mmp/iowsyOu2xE4UD77zFwS04V82466IF95r0to/dF5Qx39s5EpW
         rXBG7AM1G1w/HjaLdvCQqP+CS1Qara+KTGLeUocOUxyBg5tHETZ9xGHuLFyexaNhMdIg
         /g+ECDmeg1kfBF34JiYFF5qK/+OI2wLqlXOcVEBpCyUFsmpb/0P1I9XGOXdfdvXbBMJ6
         R759JDXmdkOTUekD7+CfnxLmV9o8+EH6MZ2kb3ct0PAQRFke2qZe+dNiGAjNUVlT4f4y
         Wl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451867; x=1775056667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGrRVHKmEX4IQk7MCycV3cbvFt2/hR4jH0QSvJAAcyQ=;
        b=rRnzED9IJHrt9jVq9ZiCT3ZPlonBGTEE7JvkRDM3LpJhmIJnq16yRgk+D2lPOjb8Ru
         P48XL6xD/ZDOnwLvD/dQU5OMnmzAPnQlfDya22+5IoqcNrSeBRTNQ/Zq9GF/2Dsevz/c
         CsQnCoR+4AlbkYnP0XeiY5HO1TsQKdkxtOzZfGHG6DzrN29+LEhwzJ+izI9JOrNpq1/R
         i6iojieOH1Wtrv0IBX9RumI2CFnK7HXQ2A13AqnOdeN0pii+Lbd67yxS+vwSv3+G8Xhi
         wl8S4kfJMuZkGBuR1hwS2W/Ze6UjMxodlIYHcUNJKj1zrhWd7ReFc8XYyvKYRCvikeS7
         aBcA==
X-Forwarded-Encrypted: i=1; AJvYcCWebBMFF04mGP6Z1G6MNeEOCHQjP9InTAI1Whl7ZOyZB4ObH2XztSVOoSZ+eY+fHBDKWbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4sQ2Uq2MtEsb3IhLm51svk6JlV3vFKAaB7rIci+Z9JA1YF1j
	+9aJOAOteldpBu+ikVuyqGtd0Z3uHQuMvPMdf5Hh9z8IqXAxQJGnpOaXGPquDtHEhqQ=
X-Gm-Gg: ATEYQzzLJ6OlFaCMQmD4xlyIE+tW/+qfirDfhaabuAu766mwxP81r+X1rSxgnwACqPy
	kOGszDjBuocrtRN9eMNQkg8jknlNdI1K6I51Nt5nPrtr36PR6MPu6sM4/Ay78LWg3ACRoZEo5CK
	h+bdhCkpLBbEyYxk6/fSIU4lPYAgz4axrtjaeigA+Y6KIVfyi7lP/C6wp8erQRgb1F2TCsK/m3+
	e9IiNiprRENERtzxakZSNwJg5eAT3596yXJawHVQlW2qys1atEa7LdsvfwDZcPwDu2miqWSRB1Y
	UWB5y9TDEMht1t4BpFwM/MTaOYR+6cDWS0EQtm37Av42FML1COsG9R3Nlo/R+EHeXflJLCibjk1
	x5+ADOTa/ABZRDfCsNgJ1QdaV8z39gRzrZMdatdsVmDmAUr9GpxVAUfi4Es/wxp21NST934Homl
	19OignKeHM0RTuwlDlLZpWXtLNd+Q7hK/ZqMRRmUyoCa7x963L8Y/03pqMTvoeZa6OL8rJk6Qi
X-Received: by 2002:a5d:5d0a:0:b0:439:cd10:aaf1 with SMTP id ffacd0b85a97d-43b88a960a6mr5401366f8f.53.1774451866504;
        Wed, 25 Mar 2026 08:17:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e708asm340519f8f.36.2026.03.25.08.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.0? 2/6] hw/core: Move compat_props_add() to 'hw/core/boards.h'
Date: Wed, 25 Mar 2026 16:17:24 +0100
Message-ID: <20260325151728.45378-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

compat_props_add() is only used by board models, no need
to expose it to any device model. Restrict by defining it
only in "hw/core/boards.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h | 10 ++++++++++
 include/hw/core/qdev.h   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f85f31bd90d..b7138f2715e 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -804,6 +804,16 @@ struct MachineState {
         } \
     } while (0)
 
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i = 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979ccb..778617787c7 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -421,16 +421,6 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
-static inline void
-compat_props_add(GPtrArray *arr,
-                 GlobalProperty props[], size_t nelem)
-{
-    int i;
-    for (i = 0; i < nelem; i++) {
-        g_ptr_array_add(arr, (void *)&props[i]);
-    }
-}
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
-- 
2.53.0

