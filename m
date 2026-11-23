Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428452;
	b=BLj7AK/RCfUNkOVrqsDtlbM6lLa/J4lffDdKvHqVKDE/mxZNy2dAq4q0dwXFVGlPlM6q
	 N5tqKrSuEHA8OyLRQxNiHd71aH0aMssfMdOeGMkUeQ+gjKqr0TAnPVIGhBw/7BSp5DW7u
	 weEZe3Txini/EqnBbQSe+5US9KdCppInxz8Z/H6pBRazO91okf7N+kcLncJ8zd7uM1N6c
	 xt+FQfztALkhD17n+M/Eaw72d7CHiu+/sGxiYusNrFywcmZoEuNMHJPgO1XFkKZ9u//P3
	 KZ8XMEBZh5cVRgKFgg3CEzy5bEQx+7fnLF/yb8B0anztxIsBuLMb67sTiWmMK41n02Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YNXr1cJRDxjFRtGHo1Yw8wGLJl2y+mtXfW9P9FUgeCE=;
	b=RxSGBb9gDGAS0jUaMaczoR9S0DTr2m6SPrG7gLRwXTdIphpiaT1Pi01rbwPXICnJTbnY
	 9M6l7ViQ03ZqHKr3TkUX5CJRdkCiJHEQy+s+Ycq7RfnlWU6iXUDrE2voLDfyLZcZk5oHQ
	 A9u6NpUmcRzpHuLtt6MaMwbCq8LRtZ0ZqbT3H1FzmO/65oRYSWpWJuDStVTTNOfwbpe8H
	 rWJqi7OBctYB8JEk0XOekqMtdfIG7BFwn11qHzIFS7NW5sXXFetTA1rhEuX8n7cu3rs9c
	 Tceqkbp/R4J+XjjflLW1+fFKw0Zdgv/lzOZhOmAwzhdQyAjuMkq9A5FgFx4LbDaEDKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQUCWc3K;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D12606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 10:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D12606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQUCWc3K
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2869792c88.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795428451; x=1796033251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNXr1cJRDxjFRtGHo1Yw8wGLJl2y+mtXfW9P9FUgeCE=;
        b=GQUCWc3KywEfq1ONwfcZkeWJcU6L2Hx2PycLnXFhTrAeH6Gzevp/76LTW3tRD5S3LA
         gZ3EnzYY6pdymFYyV29/mxm1mQ+FG6/8eD6U7vJoweA0WiWqcaJJxwLfJxKNuYJfXsER
         kDUOv+IueG+/i0RSJTa8Y7Z5ODBug5CUz5nDFLtxLgq9FrPYbjLGqQFHs6P3WUgT5TMp
         6TNe4u/BIY+fGHQA7l3/u8hH04fyF3zlrFy/zFHdDf3xEjnIlbk/hEIkQFGZ09jfbO8c
         cO354H9nlXR0hgd/aYx3VTBAWKnzfxIdKDZP3jiyRbp3+JFutEQ6WbcVfclnIZ/rv5GN
         9jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428451; x=1796033251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNXr1cJRDxjFRtGHo1Yw8wGLJl2y+mtXfW9P9FUgeCE=;
        b=SI7RgVHu8cxf+zaiibrhArAtEUo3R0fnqlO8CfWmVRaiK7ogCKXiOimmfQalM5doaD
         D5Z73AYmdrD0hhxyRqzVBI/fq8EuLhXuPjYLtRvvvYDNJc1ZK4MjP20He+W3FK0zalsh
         ZSSJSg8+b4lzg108Aj4MzpPtDInnyndquUC5WVQnFlzjFnx7J78E7NaEC6L90SkSSd0p
         T8jlEv3drXxTdVVTi7YR6nDW5tZ0WvVxHRghq0XkhdcYX7jan9rdzfcerrtNpB9TjJgo
         1MTLKMQ0xbwqOKZAMO8EztRadJ2ERhztPCyKpm0cjURvTF7zxEA035bptPcj1K1QL8xk
         uWuw==
X-Forwarded-Encrypted: i=1; AL+hErFfIl6aofpm0GjKOD1pPyvIqTI8YuwHhTyqm4NvVVZ/1ZCzLSVlRhCq0cU3GflWu53xkXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ga4M2GaOkRn/8mSDvPkxcvGIstQYeEo58JH4jSEerTtof03SJ
	mfKn1J45r5EU3YUqoQBZEdD/JSMhTEu9/tNDPvleY/OQX2YzxgFTpbrf
X-Gm-Gg: AZFdTZd3M0KHqROYqNrk0N9SS+z/XqTRJHSqC/VeMw69t39BA+s0LqaafF/Mfge2s+8
	SkxdxXHHAZWEH3p6jNTZfc1jOq3Nu2sBsn2C8ejDderQEEjCTr5zlnnHQ4rYyDf7fzk9pLapELe
	FGxXu1u6FfFdq+eh+0pguEipV/bphaIu3zF53S0Q6PJwYbz27POW/Ll6b4QOLBhqUwS6lE0sYao
	6M8I/m90yR/WapHUDfx4KorpiGnVuGRhejbS6aFpN4UPrlkA0xsdASmDLFuyWL3mBpKvnhyP8lB
	/13gr9SkJUjB2CBK4T+W9GEmywVmd+XJYcpNhPHm+QKqZjXiRuBgl5MtqQ8KyxYIw+Umqgd2Ziv
	mZPly+2L6xC5Jc4Ob11+BWA2XlEtW7riWNIR4tr+UM6p8VcMY5HfS1SUHVTpbYGKmiUajKBa3+q
	Kewq04DjaUtZ5n0dSeSUr+f1xe9UHh4BPAaEuDhEz1SDYwAlmv+yBif9yhCKCNVe7tukgRS0u9t
	aGRj9fxtusNoXSvzeH228tulML2ZG+3R79B3n6MNBk8MQNR4eIJiYV9Jykj8QHnj7WCixWw0kAB
	KJmXabYu4ILbwM2Io7EYHT6H40Dj+60DDcpK7CUZig==
X-Received: by 2002:a05:7022:ea8d:b0:1ae:59d6:91d7 with SMTP id a92af1059eb24-1b5568eebafmr10409997c88.40.1795428450986;
        Mon, 23 Nov 2026 02:07:30 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm37650054eec.21.2026.11.23.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:07:30 -0800 (PST)
From: Gokul K <gokul02k@gmail.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Song Gao <gaosong@loongson.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add the LoongArch KVM selftests directory
Date: Mon, 23 Nov 2026 15:37:00 +0530
Message-ID: <20261123100701.1679376-2-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123100701.1679376-1-gokul02k@gmail.com>
References: <20261123100701.1679376-1-gokul02k@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM/LoongArch entry covers tools/testing/selftests/kvm/*/loongarch/
and lib/loongarch/, but not tools/testing/selftests/kvm/loongarch/,
where the tests themselves live. The */loongarch/ pattern needs a
directory between kvm/ and loongarch/, so it does not match it.

As a result get_maintainer.pl omits the LoongArch KVM maintainers and
loongarch@lists.linux.dev for patches to those tests. arm64, riscv, s390
and x86 each list both forms.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..fed2245b979f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14327,6 +14327,7 @@ F:	arch/loongarch/include/uapi/asm/kvm*
 F:	arch/loongarch/kvm/
 F:	tools/testing/selftests/kvm/*/loongarch/
 F:	tools/testing/selftests/kvm/lib/loongarch/
+F:	tools/testing/selftests/kvm/loongarch/
 
 KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
 M:	Huacai Chen <chenhuacai@kernel.org>
-- 
2.54.0


