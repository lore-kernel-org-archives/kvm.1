Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669474;
	b=AkqYvSNOwQGfT1vr8usmSB69wVfwlpCISImf6hUf+OaX9tL+v4g308M2pi2vG4EYyqnM
	 N+azu5eTfB0wRcZsZvQvf/9TA5ygs7ogUeu0Th1Oh61+tQpfzNoEDHrFUYerYS6YBb/vK
	 iIGjxiZCIQw8J0jRoYUL1fvKVL6Y5uHKqTk/H0Vse5B+sUkJZXEEpCYqCCC4cC4TymQ1d
	 zFjh5BnO4rRtQrewDJ8NVcX1rIZvo4ouaEnlKQqM4D7ZFtu8VioHtxhob9g4GiuJUZXWD
	 +4cTKWztRfd0pTGZpW818N2qH+BmnAmcOyq2AE++fAOMbQlDxL/6OhsuBVse0x5uQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=crGGYNxEXyJKntahkm8iE1ek1YTEyGg3pNiPWsgpCVA=;
	b=cp81FLPzhqWqcBha9SmiJTJ4nnmD8mbzFK83JSfKpKxR1JEB2VYwvQbRVEORxT4ofv9m
	 +YJMfhDBmp5k7xVsX3WUWNlHHbL7Y8iKBgfA83z7sM8m8/cntZMvfwbDj8EiHUFrQplD6
	 RSCYS6PBi+wMwEWK6z9uwbwLFdX5EYhcOWOTCFv+7kMYvZu2OL9j6fz4yWvFYYBpbLcvs
	 9lIJs96XkgWbUnvbptF6zU0m056LO4fE7Z1uGjR3LfUi9PtQO9QQesUr/ugf9DvLy+eiN
	 4yADBIMW6lkFzSCeH2sNSOy40SJatbQvdo7sqB6qPM4W3i4kCBsNgMICfMHXaJCrslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SSap788I;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BAB606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BAB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SSap788I
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386cf1041cdso2764615eec.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669473; x=1796274273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=crGGYNxEXyJKntahkm8iE1ek1YTEyGg3pNiPWsgpCVA=;
        b=SSap788IOw1yVidTGDD/J+2IJJb94ev+hCn0OpcJgWvkGWGGYHTuxmSu/1TSDBP0PB
         T4KhNiWgQ2tFEN6HRPZ/0KewqchUw817EEqwMHqwPkb9HtlMutL/9Pv6pdw0JVRaeH8Z
         arlf6dPFN4DMXrKrgqtuvlWbxoqmuYTYFoHMl+obUjhkpn+FvoV6yOnbQLf2NX0AvBvF
         9qO+MwPFR+RsxAtbSPeyUd9ednF7D+0gzosH0lYJHzmnLtCR6+VQeGWVSuJ9WpW0nOK3
         y6GnUp78612GhohYS2pn4d6HTiPrXxMk0kLFzMPtk+pK+WzB0f1sOSWFKG4rUgpOsqK+
         la3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669473; x=1796274273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crGGYNxEXyJKntahkm8iE1ek1YTEyGg3pNiPWsgpCVA=;
        b=OZlxCvLBGgGdpwDmMCJeAIhs56g8iDJn1G2fC2cxF4jgo9tvoPc8MtwzD9aBb3Gn1n
         KLN7KiaIdGvFAs7khc1yDf70l4wPI5nd8ko9XIND0938iGIq4CpHXXMLrh14a2jIOwap
         hh3YYtt8lxcyTjg1Ypwn0/bYNwoobd6xNcP09uQcuWt0P/53uwtTM6H+bZ7qNXYw30fE
         pagI0t712VbgKR8JvhJHEcVThsSbIhbc5dAMmHGJFeR/WPiOscx4qBoj9rdGNuyTN3do
         D1r56AIz7zYRnyWcKdWvQ6wl5P8KY8MPIgL7DIdRZfOCXoQiYg6bSGXzynK4WhYxyNG1
         YNIA==
X-Forwarded-Encrypted: i=1; AL+hErFjLbxvgPnzZpjp6mPixL6hcieVTOdn2GZkwBYPkcEmivBBL7k3frun2MHUhYeIfdfOcpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oA1OItf3MzDjWoJFyAL+DR8mAnKQWym55J0bsv3cp+s1OOODV
	dw5oiBcaNDfHpC/LSMxKELn0WZJCAS4KbzynFzzRBRpaPjs9CmSPkhz5
X-Gm-Gg: AZFdTZcb7Lb9OMeuy9LdfBONKJm0uCSuId/j70Vw9vm16JWS/c3jtYbtf5l7LQafEJ1
	wa2+Xe/rG+GiISFnUgiyagxw4vONNEoZk/tOLsbtnbc5yA/RnPnKq6AmHT4hqNkWeW6ft38Ll4a
	5mGQ+K0sd49rouCTlYfBWeOjAL2DHFWZ1ixHWFpxVTp+n03wNtcqlrhzLFlMMYUSNPe/aty0cNc
	Hpf0xQ0P3m0/+ngX2RkbJJevy2GP8xUlgLhwHGer5m5z8dMTKKLQELUxi+pPgl+NOt2fKkctPpm
	g/PAu4N6inFex3CndYk+Jdjzc46+t4h1lB5p0EfdPyL0KpTc2oPxnVefr/q+lz219kZrt6XyUmI
	Zu/uuXHPSc2WgqnDrFJGWrn/5xBLWAwhKV5sWiX3Xp+3KBACawfxleDlUlOoetDG1v6pccZl8Y0
	grRQyWjbQY+UJSw2JU6FIFpwGGSOoqNfsnSKMPQPtqKDNDqRsAb2uRSwIREq7Akl+Of/uVz3MpT
	wypIMXREHtY2UnAbjDgchHLrmdZjFrf+22WhAfA2twymFAiL9mV8abYTIhdtosTK5G1WtwVP0I2
	GQ3W6oEU9F8UhyhUb8CAyRP7DKAi0SetWt/bQ4MZJg==
X-Received: by 2002:a05:7301:714:b0:36a:7b3c:4e0a with SMTP id 5a478bee46e88-3856fd5e4a4mr20736555eec.24.1795669472707;
        Wed, 25 Nov 2026 21:04:32 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm60776540eec.28.2026.11.25.21.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:04:32 -0800 (PST)
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
Subject: [PATCH v2 0/2] KVM: LoongArch: selftests: MAINTAINERS coverage and a VM leak
Date: Thu, 26 Nov 2026 10:33:50 +0530
Message-ID: <20261126050352.1957454-1-gokul02k@gmail.com>
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

Changes in v2:
- 1/2: also drop the lib/loongarch/ line, which */loongarch/ already
  covers, so the entry matches the other arches (Zenghui Yu)
- 2/2: unchanged

v1: https://lore.kernel.org/all/20261123100701.1679376-1-gokul02k@gmail.com/

[1] https://lore.kernel.org/all/20260428053204.1018608-1-nichen@iscas.ac.cn/

Gokul K (2):
  MAINTAINERS: Add the LoongArch KVM selftests directory
  KVM: LoongArch: selftests: Free the VM when the PMU test skips

 MAINTAINERS                                      | 2 +-
 tools/testing/selftests/kvm/loongarch/pmu_test.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.54.0


