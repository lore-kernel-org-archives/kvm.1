Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428443;
	b=fdHMIwMTc8Sb22Qi+kBvj7kVH43p52wrq5I/JdQtZoApOZ2yhTKLw6dUTdtvcRLlyGCm
	 eYaFiJbu+ZKmrq0vhNMrk2TYCQjVVvDKwt5frJCa3x3RyKxdbJzs2pVoVhajNgE6tQtTb
	 7oc3jq3Uopay4vvhASQh1l+ZzOXMpJ4yvHBtwiFUgFAq6nxhLkA7N56tUFvSmJw+xX1E5
	 wR18pOfqguQAj3M82IrbwgbmVq4kysZAbC5dc+RJGWwC5967atNrQ1snlt9fftCHnrHtK
	 BATy/MdG3NqdqX6KQWadrZ2jOZgxFlMky3NvE6Uq+BvRzJ7oGdtkSA/CUdaSRnA2Xvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZCV7rj7O3YjHOcFzGHR54dLdeKT96fbmxzbKfW4RNF8=;
	b=pprWGKQmQ0X7/ydr1ED9kAE+SEeTCpG7AMw4sPL/e26fHe36pVs8Y23XVYu76bZT9SbC
	 IpWy6pBABvb9I37gw2IQp3V9+aAIFUF4SAdijveByYtw/q9TyKFnzat9lKi/CfxxoDmCD
	 hoEzrpVN5JrHM9zs/Sd27XXwKG/AUUYKAGf1MWCLBLbQYf0Tfht084A/tSh4B24ibhPYj
	 5uqB2Z6X4JmlxeaSkGyqA4iXBUdwbnCHMvohOswXlmW/gezL0ATFnC+EAWa2Ke1jCiGV3
	 K8C3fvKAdnaxqS2OhnF5U5PD/dwbuC8TIrxkOAvsEJD4uNp3U/0FIGMHUmJz+Oef6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBw0kU1N;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FD606A321
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 10:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C72FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBw0kU1N
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so8584971eec.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795428442; x=1796033242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCV7rj7O3YjHOcFzGHR54dLdeKT96fbmxzbKfW4RNF8=;
        b=ZBw0kU1NfuA6MMWFZd7loTUe6EObCzE9PO+rq4XlEa3TcdREvmtLf4bUe9hjhD64fu
         HS/LcN7/9x+lK6mmuMUW1IahoFvznTlrAuq58edyJ8dsCdOmbv6cp9MNTb8g15Kkhu6A
         A6OmSP6fDWRrHs4SxaqVXJLA1urjyRtsifcEsziyIPwPksR/h7+RmL2++5EAtvlsfuQ1
         mQfUvFIXP0Ghc816rVF5xXut3sDOYksnaMNm7slg7orir13++tGmQFCbF9ti611bi1f2
         uqI2XX5SSlxuYIM4blteogqPM6FXwUrwxi560hj4NrbeihKKWQmLD4ZNzxMH+OVTBAPx
         skyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428442; x=1796033242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCV7rj7O3YjHOcFzGHR54dLdeKT96fbmxzbKfW4RNF8=;
        b=IcMuxKnmm8Sl5a4ueccqevonph/carLPZ0/lsXWzbzWiI5lXm28jui3ZBzh0ANaHtm
         O8Vy8lzxWQ6R/SQDqTiYgMwrSjZhOivSuL6UV67dd/BXzqfLaDaLOI3HAjqoO+HM5rqs
         OhQkyfP/0tU7TT3GTT6obF0380IW1eBIxiZa3+z1qoqRG/tVTuo9JDGU7YvxnnkuLgP1
         e66P6pun68g+cMb4HhiSooslf1hrmBJ/SsiqZV7I+z4ZPrpUzoHcJwoTZ65wv6sYrnuf
         FOOk6flmIvSAv7HiGxScDrukf26t5HLJPScYjEDeKGOVYY/50qoGzU1+hVgrE3VYY+Bc
         WNaw==
X-Forwarded-Encrypted: i=1; AL+hErEuZf8PqkuqHNQ5vcxyDdRFizx8nnr83G5PLTkJLwUKA8ZNZ4lC6q/MnVQJClkGB6Lw7io=@vger.kernel.org
X-Gm-Message-State: APuU4Z95D7e2ThupsmuYsKiwpQnQ8JcR9pvSf30wV9T+WqDnj3P8VYC5
	jT3ioIfN1l0arkIYb7rGbg2ivy0YTuTGK87appsKlOKJy2ndemO2LrSb
X-Gm-Gg: AZFdTZfEMDQfECBYTaHnYzvzcc1VRScqxHxodSphKVINl33M67cC6jsJYv22+qoXVtN
	1OayuWRmEOwYbO9e8InX11dKcw+0P+LuXnaE/HD8WELUrKVq18VIvW1dLj9O7SW87cMQIik8w4h
	XwK/JqmslLaSi5DeER2eygRhklMNGSn95f+XirRgihBUlZAr/jo8YCGTJt7Ca+H+XrCY39tolv7
	OfIEhPU/EpM3Lh0OZ3twGy5UEzXjjuDPdr6rs9vN5S7/QCqgto2X6HGGHrHYZIpVQcaD3l8OVzT
	pcvNGJrQ1lcQ2FLFFneIx6yVQpGDNBBiEBkNxcSmYoK1i/YwxXgjL3GFjigTlSzY11Wgy6foSKW
	/faaJSGLaEHiHAqNGEt8kzjrTfeHs/TjIWYy+WtGvsFPJezYhpEOSDWuPq9Y3L70oES8Te9k7tN
	QLtz5143eg6UXVFYLHZtaqWnF8Afk3SVXyxbqiMMikRbrarLqXQC1ZZH8qp46sqoR/JVjo3gv7X
	j+V0hvtmCt8bie2bIIQnTX6ACArRZ1Lc8C6M2erlppCT4SVGtKJLvH4dntn8n+ig6qmrs07C9Ck
	IGVjFggQE0sA51j4/9Ryw604XY3YNDuMfBjaCZ2zHw==
X-Received: by 2002:a05:7300:f498:b0:386:a716:916b with SMTP id 5a478bee46e88-386a7169544mr5039152eec.31.1795428441777;
        Mon, 23 Nov 2026 02:07:21 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm34145673eec.15.2026.11.23.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:07:21 -0800 (PST)
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
Subject: [PATCH 0/2] KVM: LoongArch: selftests: MAINTAINERS coverage and a VM leak
Date: Mon, 23 Nov 2026 15:36:59 +0530
Message-ID: <20261123100701.1679376-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Two small fixes to the LoongArch KVM selftests. Patch 2 frees the VM on
the PMU test's skip path. Patch 1 came out of routing it:
get_maintainer.pl did not name the LoongArch KVM maintainers for
tools/testing/selftests/kvm/loongarch/, because the MAINTAINERS entry
does not cover that directory, so this series would otherwise have
gone to Paolo, Sean and Shuah only.

Based on loongarch-kvm in linux-loongson.git.

Patch 2's hunk sits next to the one in "KVM: selftests: Convert comma
to semicolon" [1], which is not applied yet. They do not overlap and
apply in either order.

Compile-tested only. Patch 2 builds: tools/testing/selftests/kvm/loongarch/
pmu_test links for loongarch64 with a GCC 15.2.1 cross compiler, using
glibc from Debian's loong64 port as the sysroot. The binary was not run.
Patch 2 changes the PMU-not-enabled skip path, which only runs on a
LoongArch host whose VM config leaves the PMU off.

[1] https://lore.kernel.org/all/20260428053204.1018608-1-nichen@iscas.ac.cn/

Gokul K (2):
  MAINTAINERS: Add the LoongArch KVM selftests directory
  KVM: LoongArch: selftests: Free the VM when the PMU test skips

 MAINTAINERS                                      | 1 +
 tools/testing/selftests/kvm/loongarch/pmu_test.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.54.0


