Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906631DB92C
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756786; cv=none; b=ou2gsQPKKwTeVSCEZUIE98YEYToHZ0nRQXDKbJWaCk8p0Tfma1Ekc/rGig0+kV+Bdd1I9scKy5OA/6JGFxrOpmmFVTVgQE0G+0W+1TzQJqvhRXHYwWgPkCuGxyLITjCaB7GU8yQPtYQPSqz79TPkCXQiCv8l1EpEn0ZHHMnfp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756786; c=relaxed/simple;
	bh=9EXCGpVfKBQS8nqmv2M5Um5dB6Qlnfw/r+giCzT8iM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bG7cizsgNF/wlE3wfMpTgpAqWhw2CIId+BePVy+RVUkoCQWQ6PYy3QhFRG4+pC6ueuk6QNpa9s81iH72gv4Krng+i8oNG2Dbi0VyluhVCJuafMGa3Kb2mKir6nludX069JHVWQIKg71qVAr44X4sjXmvBmRwgAmYQPJOTQMXens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piX3dBx1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piX3dBx1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39647184c73so3748198a91.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756785; x=1789361585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DoQ4v3sOG7iCAF7e7sOxPVMm68Lco8LL3+nPKFM7Lg=;
        b=piX3dBx1CxIdvHXKLZTDwKKP7ZR+CFGe/mhS5HemZ+VVyNiw+w9ApZegLA6fnPb3ew
         NWwIRzduvlcEq/PfYFmHfDn4bw9yYwXMF6bAyLrW/Te1/98sLJIZazg4m2KIRvA8kXx/
         HBiiRBUAmtzyEWo0McTjWD8lujhQNgYFnL8ahOym07QlZfueQbfnyU9jFvz+tly/IHgn
         I5Yn7DCNQSOlGU5cgf9dnqKIPRme+IVdJSz2rJZr88mZlmryM3x7ZEmPKsTd5BCuqeJl
         mrkt7Cg9N09cKaqrxMKLqyxRv8iebgIF8b5kUpLAH1hp3R/VHgWXt4wZzgh1aZhrkoLE
         6jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756785; x=1789361585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DoQ4v3sOG7iCAF7e7sOxPVMm68Lco8LL3+nPKFM7Lg=;
        b=eMjk2IntrzWSIoGaDM/7ERsGelkZWFN8ddo+rDht3cbuVTCOsJvrFC9qFRoYC4rnuo
         ICJghS9UzC6Z9jpUDda54J6Othi6HldU5ae1JfPhcDUdbJM4+TmhjDw4KWrIGupNdqc/
         dvb0sYWnwfRJE4btKDxeiwMYJOu75v41vjE48C/SrrXY/D9Y4yNWlkNSGsKibFoqgq5H
         1uYFPAwnyU5kP99JxG4irR/3NPe9E8d8OVibd9QSWSIwL5YT2rmgBxfurqCRZMMj8j+j
         qy2JnMtbkxZi3k/Q7+D9W3qulGxxU9uXB1So1HjMx+1vbLzcxz8iEry9AwCdX25pULEv
         n85w==
X-Forwarded-Encrypted: i=1; AKwUvBzFekNUuIiz2+aTQrlYtK2WSOTJVEsArm394r/gjAESXEe0zpHUg42X+fa7jb4RMm6TXXY=@vger.kernel.org
X-Gm-Message-State: AFuF++lBNpvFNnEojAs9vMe11yoW1ar8FXVSCwrMwQ969kn0Tycgr/oS
	rIXMRTMY3JdUuK/q7unWZUy5HucZJoE6Mhl2btnO0R2wTN6EJGtp6MsA
X-Gm-Gg: AYBFou07TjF4Fs2OugpD2olCEeQ2dPtQ+8tqzOTHep8A+x89ZPRlAxQPgN5t4fl0nRd
	peIFy+rWCEwob2h7yybXoCtj5G+I7NZaJ+KQU1A0fVDZ1jch13sushtSop0zRalzEjYD+GnZ7dg
	MNTFi/bfQzQYuFNXUxsKXydW41sWLcJFCG6DdMZpSLzo7EWxX0rXBPMKofMo9QAbuO46s/FwtCi
	Y+IaD+aA+INRxD+5yqYSY5ZC1WE6+9qpkz5AEqcsEmIcgILqMfpPyyaCFLpK6ASN+rNxB79XC3j
	lAPL/8nG81bKfR9//aMVZWxBTTI7Idi2EJqOTbG4jzsxyqkLXQN1RsY832By8MlE62bbiFAyHS/
	sia3iq0Em0lVIJuI39ir1a6ET5alfPScdiP6+9Spdbt/TdssQsHfIvkCy+tE5CnXEbE2IjUhKhA
	M561Sr6hAnu2D/sUHVZ68JUoXly6XMOHWDjJyd9jFlAMQ+JrKUZQz/zgRVl4h579grIsQitGNpY
	Q==
X-Received: by 2002:a17:90b:4ac5:b0:398:9beb:a2ba with SMTP id 98e67ed59e1d1-39b087fb503mr29944113a91.28.1788756784912;
        Sun, 06 Sep 2026 21:53:04 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm37641639eec.15.2026.09.06.21.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:53:04 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nagachaithanya9911@gmail.com
Subject: [PATCH] KVM: selftests: Fix the never-true negative UFFD delay check
Date: Mon,  7 Sep 2026 04:52:46 +0000
Message-ID: <20260907045246.3783304-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

demand_paging_test parses the -d option with strtoul() and then asserts
that the result is not negative:

	p.uffd_delay = strtoul(optarg, NULL, 0);
	TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");

p.uffd_delay is a useconds_t, which is an unsigned type, so the comparison
is always true and the assertion can never fire. GCC points this out with
-Wtype-limits, which is enabled by -Wextra.

As a result, "-d -1" is accepted and converted to a very large unsigned
delay, causing each demand paging fault to sleep for an unexpectedly long
time in usleep() instead of rejecting the argument up front. The return
value of strtoul() is not validated either, so a non-numeric argument
such as "-d abc" is silently treated as a zero delay.

Use atoi_non_negative() instead. It rejects negative values, unparsable
input, and trailing garbage. It is already used a few lines below for -v,
and hexadecimal input keeps working because atoi_paranoid() also passes a
base of 0 to strtol().

Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index f8b3d0b68830..619a0b2be45c 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -297,8 +297,7 @@ int main(int argc, char *argv[])
 			p.single_uffd = true;
 			break;
 		case 'd':
-			p.uffd_delay = strtoul(optarg, NULL, 0);
-			TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");
+			p.uffd_delay = atoi_non_negative("UFFD delay", optarg);
 			break;
 		case 'b':
 			guest_percpu_mem_size = parse_size(optarg);
-- 
2.43.0

