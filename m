Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1473C3431
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919241; cv=none; b=in9//IB7NhpAeiccWf6hqk2UaMKe5VkRjmPzWHUB1vTtfFzOiyVY7fIwreaRznXRnp6YR7YAvqcw0EGxc2GUqIe92a5ASfy0UaRD0vDeG0y2r/dneD5ji4YwFFQznvU1qOIRgj56L8qsRuWF7TyCSxhBd5hB46O5G6jpeJBoEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919241; c=relaxed/simple;
	bh=sN8SCsE1sa8IYusS23SdzbKfwzpnWmxClyBmy9JFgYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5rGHAkPgvavJeeABT1cpgSBhD5hH631AkWnN/OdtY655UUK/238wdg7vOjdt2qC3HZa+so2q0By1LO7pCIZ7kqF5WkkG/FSdkmpBBBUN+S+5pQFfwDhGhcGV9EocgpHSgbJqqiBnPB2Lr2F+cgHZZXn/t9RU9rHsLUSuHeWfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2NCnY/b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2NCnY/b"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd27754bso1612245e9.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919238; x=1774524038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILd32R5A8XKeMpYg01CS957pigNHqjKdgnpyoMw2kbA=;
        b=s2NCnY/bykKyIL8fIe3si/YIwjFu7KSRI8GKKrxc1LSfGtHw/9hPvss2GFK94RY5ki
         FLBPMo3ABCgZUD6ZZDyeW2NGu9WBVd7hrQ4gU8KAsnhH0ZRmngzV3zKgE/YcS/oyB19T
         SNHsy7f5MKQGE+j7b3VRH7L4mh5AoullQJwVQLAZpXjmzRNOxxEZHom06iYAWtrQ/vy0
         WAmSC8Sn2kNbQRAsAbGjI7c/JlHqJ1vdbkuQ87MGhtsZvyrf9QzQOLtrGUidY24Nby76
         o+QjKI816kaFFPngkeOVQW1V23BWyMWBIGFW2kFrcnJGR5TOOgfvs5tcAIIk5yaEnyzf
         c41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919238; x=1774524038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILd32R5A8XKeMpYg01CS957pigNHqjKdgnpyoMw2kbA=;
        b=aDfPUJbLPngzyNeo9LTSEnq+L/tKT05sYWv07ysrVd5sQeWrn+iEJylAxTv3lAOUzl
         C7r9boGjM6ofGeVVN/NODwK3NOceAlR/EYmuMR3ZbKQtS/fKRrqmjOQFs6ElsPO4YrBl
         tDIT0xzSj4qgNq7GlGJqp0jSNvpX6W2qiCyYZs3ys9OAij/gyhZ216W7pviT4Nirdpel
         DFE2G+ZlHAYY6fQ4chcBXdsN+7o0VV+uvDB856Ckm9XbiqYGbSY4kEX9UxgFe0LXT6/N
         jE14WuJk18AZAdHHRwsfECT3Rq8Lq11lQVW03hBM3TRg/ARCGRwQ08vJdeXj6xGseTfF
         s/aA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7TNaWuTn7Brb8v8uU+iD90xFGEfdpUfaWXC60PjPY8fx5D8CmcWXsWLI6khs/8RIgE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPZFhBoH0q1g3ZqhZaZHPAJj7x7zoqisX4j1LEPVCUpTjH7/A
	LazXXQrxBo+Qgl8QSIO1qjcH80WqTYDpM8FceJnomDFgsDJoZxz/8lynvBJrkjt1NXY=
X-Gm-Gg: ATEYQzzDhMlNkhgMwD+H2e1KQMFPG51c67DomCoE05KPqGenlcg+sWY4DrT7dp0JAdg
	Q53/tnHLYF49Qd1noFc9MoB3wrJONN0solu4r1cb5cJpGCfe7aVSpffE4RqHKwKkRiVqvClVUzN
	Xg8+YQyJ6T5qDXGzdCp07DmTnFPRooRXs2zqQgMRWzaTPoIrSx/0yY4wb4kjXcurwjiioW0OZ7L
	UN7JO/FoE5P2Gl7N7W+RVAYHqdBwSTXSimqntVR8jLOveSSrmNIBOG19/NnHsGlc78DlCzYlpP3
	EIx9lhiNyV6KeZin5V7D4Q/QwmN5D9+KSECgrRT6aecU0O6fL5u8orA46zH+FaULgp7r3lnIhOZ
	8kiwrO7xPnok85VSpZ706jgDhk1BBoTmBJgKN9Hr74WnlX/VzjFjh3p2fVWW85ZrfCmaRgUZ9jp
	EjtdawZjhoNFYxguYrPnzfT4gTjayZmRrvif4bh2QnS6P7xQXg5JSP64qtiwuztYeed1ZSi2QgG
	3Br+Ho4Dsg=
X-Received: by 2002:a05:600c:630f:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-486f443850dmr121722005e9.1.1773919238343;
        Thu, 19 Mar 2026 04:20:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949a5sm56957205e9.11.2026.03.19.04.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] configs/targets: Restrict the legacy ldst_phys() API on PPC
Date: Thu, 19 Mar 2026 12:19:36 +0100
Message-ID: <20260319111936.68041-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 32-bit PPC target doesn't use the legacy ldst_phys() API
anymore. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable
to hide the legacy API to the qemu-system-ppc binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/ppc-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..ae7d593bf0d 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0

