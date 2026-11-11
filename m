Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470506;
	b=QvGKXpiKEE8UG7/zq4Casn9tgu2MS5+guV8VO2E4KR4QBQJjGask9kYJ+seHHule6l3O
	 qVEKpDxnzI200pb5F2uaT/hbMMKNoZS5nkcyW+XKhTTAaOtZiyGLWHJjkRMcScqiQuMoS
	 wBOmPng9rn5ghXLCREQ3drxveDHRRgJUMkqRSkegfAvVpIS7tKkJFYiK6qALodVq/hlFi
	 U2S+pQroRtIdp4o8LZzlNgjHoyLWvOt5qpRVbr9b5F0SvtuJv/IArGnarK9AJRrGGrdvp
	 C1uskFgQhLZdLqk2gMP7ZnARlRDu53WnBxXVvg7O/7Mu/yVpvkbIBb+Z2j6x39IClKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470506;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=WjKO0NSg8lPOk5mK3slLkPv+yGSOHVDOie0hk9bAwXk=;
	b=lcooybLSRW/PYY3AwjR75G/Qz8uo905jFd8CgUuAAUq18C0h4RqKUl5PBQ9qANUFBRm1
	 iW2QfUulNj4cMo1EniN5AvmAJPJ8+apltH9VZk6P0hrDb7EPHeHNCB4PtPW/JAGMaF8OH
	 8rY5gRuHlimxG1PU9aXIC2biyxFaNd816bIdNG4Qh0r0iLr2lwowu5AlEQGOM1nvnOPW5
	 xU393oFcEJw8sgJUoSelieH5CJJB5CEsfU5/ezUYZ56Wmav3EsQr62d/BTLCTfxsgUuJh
	 RC9AhcGGctt1z+zVQ0zSJICJBcMLuaIiLP7AqwiFqJu6Wt8rtugACL/NqDdZ4aIRn1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MlW8fBiq;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF775606A323;
	Thu, 12 Nov 2026 08:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF775606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MlW8fBiq
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jQCX35103zKnm3;
	Thu, 12 Nov 2026 09:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794470499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WjKO0NSg8lPOk5mK3slLkPv+yGSOHVDOie0hk9bAwXk=;
	b=MlW8fBiq3WE3Ghcf5Br1fxuxBbOzaTSe7hAgdjhKDsPaMMsg/8Cc7dtxsHGhncE/woOMIa
	6xe+ZY0J9egGhM70fhIF31eIfrz+cJfa8MPdn7ghKyR2Mt4Hc1NQkkE0JndUMsv+AekhWy
	srUPYZ6itRYyTrrz3Is7i1Dz3zkFGqcx55DysLVyaPr29NdUUIGakcmqgp05DIjl//qZuH
	UvBhW9QBZG3tzjnZkr/DehKmRhfNmvbLU3m9G02Pzxx5fdjZgjKMzv6wONgSFVl5HL9tMp
	ixn79j3qNRyWBozdBY5gKbyUivyx+cGXEcqRVOH+oaCdFZdTZgRUKII4MSv3Jw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/virt/tdx: remove kernel-doc syntax from comment
Date: Wed, 11 Nov 2026 22:45:40 +0100
Message-ID: <20261111214540.681690-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
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
X-MBO-RS-META: js4ooj96n6zf4zrf87697jkz5j5f76n4
X-MBO-RS-ID: 03bd02e19382c9c5b13

Remove kernel-doc syntax form multiline comment, fixing:
  $ ./scripts/kernel-doc --none arch/x86/virt/vmx/tdx/tdx.c
  Warning: arch/x86/virt/vmx/tdx/tdx.c:123 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * Enable VMXON and then do one-time TDX module per-cpu initialization SEAMCALL

Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 arch/x86/virt/vmx/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 680e5178a8..4ebbd7d059 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -120,7 +120,7 @@ static int try_init_module_global(void)
 	return ret;
 }
 
-/**
+/*
  * Enable VMXON and then do one-time TDX module per-cpu initialization SEAMCALL
  * (and TDX module global initialization SEAMCALL if not done) on local cpu to
  * make this cpu be ready to run any other SEAMCALLs.
-- 
2.56.0

