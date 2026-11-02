Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633841;
	b=0sMHrNlfUhJ0t2ztlhZ9JVxDNst2vUB/kaoGz/Z2Q9nt5K/PLHop3cPe91/naguuzfWs
	 ipLU3SGH9ZaS4L2PwBh5H4alqdB18KgyBaSHFbtqgjycMf6cHDnT63oSFm/H0DuUl3GRB
	 uoYxGkshwpby7F7FZHxtevnEJdN1mIsyakTzCmPNzQ2esQnbm6Ijgdf/EFmFfEiLidal8
	 xo6TyGuhFo+vQ6Bxo4VTq32V4CtYQZypyEFHgXUa0Mf9czBHeLKTWFQgOsZ4+yTYW3MMP
	 NkwWHUGDdemn3cp1uoeglm0JqJriEbj41bcA0/v257undvZEhRp5t3Hrr+aKf6pCNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
	b=C3D3vWaaOQ0V3A0K8ZOxdYYcaA/oeVl78j3e8xWiG11ExSbfxI2ZcQAtfEldAyMyj87a
	 ZkdlgGCqH4mZnULqrBqnBBuMX4Aurzq5UsPJhI6F8tKoQal28pdTEeXQ9Z9XTduGgnLqL
	 RYx6SAv/u95gfjGlMHvqGCBCcgkPmvSvU6NlSuBbxco1M2oRu1vhwnAHEPP+nIblZyH25
	 BaxN8PBmPVB0ZnMadFxw2jHsURaOVZ+EubYY8qFl0PTZ3pxAomPFaFrXYpQQJ0Oq3LMNo
	 R89avb6XjrEjMLBbRrsTMevJN2J7uV67tsmV4xxgu5qawuPPmVFuLn2XUUXsrMNnOkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NSzJydZv;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727560EB601
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2727560EB601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NSzJydZv
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e601800e58so51290015ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633840; x=1794238640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=NSzJydZvMVXYxTC62CIB6ze6cmzNxnlcYaAgAV5q0w8GPnprJgO1rjDotE1ldsqVF7
         id7VY8rj8sVMHSKlTmzi/PwHWNeII+QwqojnCqdiqX3PxCO2GIn3vjlHmseHkMN5XYqg
         BYPAspktX6r0+V8A2/zX1+AyJq1DpXHLE0LDtoRiJxXMg8DAr6vPt8WXhLgLQF8ebD15
         QcofgRuBHeqjWN5y9E3jlhTLHW98sFut6vpM+lSkpNsQsFyL3sjc0/ACce80N8Qbe8HF
         sfB8sbQFa0HOWibvXSBBCPqGq5tFavtJkOEq49CN4uJoCYR6CeAVMFVKwOily0i0nNoJ
         IFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633840; x=1794238640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=W8H1KbpQr8Z/cOpZEvgr2RRIziSz716a4BjamjF2S0lj/7F5CbMsajWMjAWpjjulhC
         aLZGxM0meIk5Za5V+zsKuOOCQD+5lNTZkkOqycZi8y1f9RuQ0yV6ZbAilxSJrU4COEC+
         c4URY/LJ0lAJN2n84AoBiHQyl5P/iJazBzevXOL9ashBM7Q9/muS9+Nq7KBbp0iwHbk/
         /VN8X4ZYf2PoEUEHLUnHAQAeOvXdzjU/Q5b4RxGfQJhYGHTanCyUtVk2llA7mmaabos6
         asSUUBWvTIAwyu/4fj6KMCHmAh7jPi9v6RmqFzD/kuHwo+4V7j10fa+xsoN2tMDwHoBL
         PLqQ==
X-Forwarded-Encrypted: i=1; AKwUvByABNmj4eB1RCJWGvfAS0P1MkeUJsZHfN1C/pu5iRcVFz8OLkpDbk3NtRlK6GIppXKtecs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BmEr5CQq8XE2bDIkFJmKVcMHuuwR4fd/2AC0NBVdp1y0p1ljI
	TbgAnxLoD3UWaQR+C2YYJ9QtkoQG9mip4Hrxq2FZtDbAnLScCLqHrcAoQpd6NihkNA6tlQcALHe
	2UT4LxDeHVA==
X-Received: from plbix15.prod.google.com ([2002:a17:902:f80f:b0:2ea:a5c1:240f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c7:b0:2e8:b5b2:a9f9
 with SMTP id d9443c01a7336-2eb364e9f75mr92959155ad.37.1793633840266; Mon, 02
 Nov 2026 07:37:20 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:48 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-20-vipinsh@google.com>
Subject: [PATCH v6 19/27] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index c2764fcef31d..ece2a3618f2b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -34,16 +34,18 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-$(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+$(TESTS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TESTS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O) $(TEST_DEP_FILES)
 
 endif
-- 
2.56.0.317.g454f8302e1-goog

