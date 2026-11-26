Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722882;
	b=fPBCEAsJ2FGpykMfEHOKG+qpHCPZg3Xr27ymoLOPoClpkmaUWBf78xnvL3KYaam0QCHh
	 fkWhvvI5ne/i3q2CJrTwEhxeToOwV5hHPnq9Ug9bUGVUyUxNHz3su0ZLJqVQUH+Ye0Qoa
	 qxfvlP/jQapbHin9Ime6yBj86eb3CJWscVXOK2AK1Z/htGzdxhTXlwE1uU9cjvO547um1
	 CYD0cULa6lpUw/22BeNbmppCCAjFryrrUzsh6doeatOqB9QUJdPqDcEAjl+1qGQYs6pMQ
	 3Hxc1NpkW+GGWY5OYj5vCwjC5cy2m6/iRINjLqTGwrqP1dd2yuRt3Wiy+euKG830VXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722882;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5eHhqrzCX93O1QdQdWrfvNrIw4EIguxLtR+WZXvv1ws=;
	b=J0AhwIXbgogFJlxZgan96/vG7H9nwVcXBO4c9WYv5n0etdtXi7l84fftOnqSxNkfOltR
	 i5eATSALjWmndIFcD3X7q0hsIcKu3T4NHEsgWDtETcA1jKlPqfMklNaFu7H4Tu59l6iH5
	 CNzFssbrdHqEvcqV2O0gTeqaMrqiNJnRR+rZZtcU71f8iSPjAwx0SZ0w7aYBTFVdmMNfH
	 cAAoGJpuyx9ZugVRvNYvHQPVOPNuj+j8qg4aqODZT6dhi3sHuoysT0rYqAvPLQuXgPwYZ
	 jM65VbJ2RA6Id/ZmJZQQlupNOBYjaBu6qC81xMFj7oRmUjSJHr/3PVvP76m+NDaKZ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wM9EqMN6;
	arc=none smtp.remote-ip=91.218.175.252
Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02F606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 19:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D02F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wM9EqMN6
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vF8hjqe/03qtTbV6lJsRt2aN0/Xo44z6FuZr4XUvVGs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795722879; v=1; x=1796327679;
 b=wM9EqMN6XMjpUJ4hNSqXkDVPkkFWrQwNhXKSSwCTb3+yLNs9l2kxV5+kZsVdYU+BDkzdGZsF
 A5Jmd+gtkFGOxevI7xHRD9fHG9ToXCx+VwwV14Bw/2s2CUg2OvEHkpO7w5rVciSD9I2cHRJwEgK
 eDAgVFF8BIaQ52CADNixEZS4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a4b32201d5ae4cb8;
	Thu, 26 Nov 2026 19:54:39 +0000
X-Mizu-Trace-ID: a4b32201d5ae4cb8
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: kvm@vger.kernel.org,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH kvmtool] Makefile: Make the clean target independent of the build configuration
Date: Thu, 26 Nov 2026 19:54:38 +0000
Message-ID: <20261126195438.3313169-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
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

'make clean' only removes the objects and dependency files of the
configuration it's run with ($(ARCH) and the optional libraries the
Makefile detects), so after a cross build a plain 'make clean' doesn't
remove the objects and dependency files specific to the target
architecture.

Remove every object and dependency file in the directories the Makefile
builds in, along with guest/init and guest/pre_init, which depend on
the configuration in the same way. List the directories by name so that
objects elsewhere in the tree, such as those of a dtc clone used for
LIBFDT_DIR, aren't removed.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 84b8baa..6698cdb 100644
--- a/Makefile
+++ b/Makefile
@@ -557,12 +557,12 @@ clean:
 	$(E) "  CLEAN"
 	$(Q) rm -f x86/bios/*.bin
 	$(Q) rm -f x86/bios/*.elf
-	$(Q) rm -f x86/bios/*.o
 	$(Q) rm -f x86/bios/bios-rom.h
 	$(Q) rm -f tests/boot/boot_test.iso
 	$(Q) rm -rf tests/boot/rootfs/
 	$(Q) rm -f $(DEPS) $(STATIC_DEPS) $(OBJS) $(OTHEROBJS) $(OBJS_DYNOPT) $(STATIC_OBJS) $(PROGRAM) $(PROGRAM_ALIAS) $(PROGRAM)-static $(GUEST_INIT) $(GUEST_PRE_INIT) $(GUEST_OBJS)
-	$(Q) rm -f guest/guest_init.c guest/guest_pre_init.c
+	$(Q) rm -f $(foreach d,. arm64 disk guest hw mips net/uip powerpc riscv ui util vfio virtio x86 x86/bios,$(d)/*.o $(d)/.*.d)
+	$(Q) rm -f guest/guest_init.c guest/guest_pre_init.c guest/init guest/pre_init
 	$(Q) rm -f cscope.*
 	$(Q) rm -f tags
 	$(Q) rm -f TAGS

base-commit: 2f3abe56dcd2658dc6dae3eeeb4996dc4b518bcf
-- 
2.47.3

