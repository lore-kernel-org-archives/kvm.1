Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538288;
	b=mCwWs1sgdLAYqcRvTrCaSEmcA1jVvElaJoAAIpf82+zlR7ojzWPaeZlHxasENM4P5XHw
	 2dtCi4CH1iqpecQ2upPCG4BqEZ+vUzgJ0AeW4/pfR9MaHcQ82F3hvlfIxMhA8zbqIXmPX
	 E1F85yIltCbcuqmEAX6LeamyQ8F1q+iAKyrrUrMSeVzW/ZTFNN4PVwY+Y5op1iSpn6Fig
	 9ke7Thei7XI7fdyr5lQmJCJRw2ht80kGduHV/DpW0M8zgb/mTUDDcUcO+kf1IMKAMPUdY
	 yXbjnn5bfI5Ks2v5LFXh3VQzpcBjnKBx+xv860csaIC/y5ucDxbub7PQ123yoBIoQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
	b=0QFlZGTjGy5sTX6BUnd3aFVjCaclNEpKiiA/rRw8vIaCt1wWaoXDXcQ1R5GdMW4nC3LJ
	 0G8dIqsBylkC7XD4eznFguU03fEYgnkEMf+KcFIgNQjLvn1lcMv7PfVybLEO/aeurR+yh
	 kuRiTR6gs9iu4M1oA8lq05w5dNYU3HCQbI14wQWpx5r4xFZ5PeoDTJqeQDeIT5ytO73jy
	 I/YBUIgsezWNgEbDOJRxYhcfAYgVXObc+DWfKoDiQT/LU5ZTcKkBVisnuI0OrK695jc9h
	 w4GqWGwFJ7E3b0jrty7bnzc/PSGKXAG3rylDVOe8pDX5MPDdzaxp36y365j1TyzQveg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2G7ukno;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE606A88B
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 02:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CCE606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2G7ukno
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15dd124bbe7so324228c88.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 18:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794538287; x=1795143087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
        b=i2G7uknoqdBWgjPDKz8y/PNjonAjgtkQO6fGdqmFKG3sItcnMUBcDAVrVGW91JHH1v
         HFzRTlfDGoXH9AyBj+T9D0RQR73oRer267APAHEwciAUMZTARG7DXlniJ35IXE9WL8Eg
         iUZoRRfcqs37i+qZ538s/pUf12a9kP73XNBFML6foTnfddIWXS//3ZDNtzPORZI8hTrY
         Xmg644fZelbMyUX9doOFUQVxntsymrqwfrWUKbfztvX7HCcJ+xWJrsmkCr12zOUidgjY
         wtMRi8Z6FFGoOIxHugp64dl+uBogkJpUSsKvj5WM6esXghsTrly1YE/gk0Eg76QYn1Uu
         ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538287; x=1795143087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEjGpvcrNvlHhAnch5bFQ1ZwAUgnUCLZ3mkaXsk+SiU=;
        b=qwmAPfCK8cnOLvLFFiEIyWLKqpjfz6xKFyGk4OouAgTaC63z5sGqyJeA098vPn7g11
         tszVUbhSNxAXIWhR6yV2JucccHFm63FaKimuwePprF+N825oUQK22HaGxU3O+CQoapX2
         tkYQQeZqrYRLPtJ7xwqE8a7TkdfzgNkP7C2wq3FcOunSxsxvhV1FOqvbk5iXyCqI7bQ1
         bcx0tIKptYFq92T4dcEonxrbVwkGz5Y+BfIxUDAfbX3BlBiaBru4uCliBkbx/A+3/t+y
         3NA5hOI9dJkaT0FTEBqdkf0h+mVUn7Sz9Dtkn3ndz5FjH9K8X76VaAeZY40rIhr5v2ci
         Gn3A==
X-Forwarded-Encrypted: i=1; AL+hErGm0oTjTaItGPt4uIiFvq5NaqGdYtQhy3kexVSp3l7vALDlweN6x/FbwSaLaKbmzuuV+jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7BdtqS7Pg2E1bd+T6F8D4G2IXtEP2nmCAptaGE1aeJE1Ji91p
	dmnT3htoC2PXVKwtou0CG20WERk/9juW7qj9udhyUPiZGAK6zZ6Ysx64
X-Gm-Gg: AYBFou2+VG3utJ1oG8ivNdPTUbNY+8XQ8+oHWZlZRLQYKYptVqgnLikTO+RTWKmJe51
	7IA4XJ9mEix9I69vyixX8IL3q+7kykKddXAoqZhK0ovt5MNfqBZNZ5EObeFIQHz+FvBc+BpQCuS
	7AEqF6NVkpjnsvMJgZctv9Xb9QXdjMb8UljbrMDWrPmOGEmW3/qPITcEWdrDNppvkVbP/cBCuTt
	Gr6ogOBCm2dJrE3v2mmAzsBbUg7jiLwJaBY7xw5yPZLYmar0Jr6Wd/oZ7R6a25moOWk5Md7w0rP
	4xh2mBIzbhsqshWuIEoy2rR3sLdnX1zPO7QCWwzUeAL/R88c96mvZLXRORb2FNjoJp/RN9jGaUK
	50xNYy4SvEIfFQFdUDu3uaeZSIYWZtyJHOEZSu2JWGpbdnQCbVfjxcdE60jDLO5TvyYy2OYJlI4
	EueuhZPJpX073c8BbeO4QTBkyQMIeNuNXI7QNrsXg+iNvUiE/YQP/EyB73QoKZeOT64DUhjBlB9
	l2iTfTGfbRsyrwDZEhU1lTu5H6MqtmVtwXoqpRRPVzXKIWtCWiAj/o4hXt5aC8K4fw8mYrtBjqU
	5nTtx8ssY5w+6TYHybmCBCYKZC9/fqgz4Q==
X-Received: by 2002:a05:7023:a4b:20b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b50314bed1mr1240666c88.15.1794538286798;
        Thu, 12 Nov 2026 18:51:26 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm2853771c88.11.2026.11.12.18.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:51:25 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-mm@kvack.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/2] KVM: PPC: BOOK4S HV: Fix memslot rollback in H_SVM_INIT_START
Date: Fri, 13 Nov 2026 08:21:13 +0530
Message-Id: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

If registering a memslot with the ultravisor fails,
kvmppc_h_svm_init_start() is supposed to undo the memslots it has
already registered. The loop walks them with "m", however it wrongly
passes "memslot" instead (which failed to get registered).

Fix the loop by passing "m" instead, the memslot which was registered
successfully, for rollback from the beginning.

Fixes: 2027a24a75ce ("KVM: PPC: Book3S HV: Disable page merging in H_SVM_INIT_START")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 463aef870c4e..190f64d992d8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -497,7 +497,7 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 		kvm_for_each_memslot(m, bkt, slots) {
 			if (m == memslot)
 				break;
-			__kvmppc_uvmem_memslot_delete(kvm, memslot);
+			__kvmppc_uvmem_memslot_delete(kvm, m);
 		}
 	}

--
2.39.5

