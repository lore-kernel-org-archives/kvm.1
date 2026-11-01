Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546929;
	b=aJaAmf3AVUiPPqKWykNSXhp/A7QXLx5fK0pjQUmYZQhbu5JreGZWRPulxFZQlNEHUwJz
	 73Mb92ZKxdB4uus4IyLhsL/PthiAQDBbvzGH34KjiRue13q+xp5fcDinl0XgcfeOAQXxn
	 tX3PaXceC3PjSnVRr2pq77zZ3SAbCq6HHP7Rvu5Kb4dX7JK84zvtav6JEWTeisAuWI/T0
	 DJBlr8xL+cNKOuUYwPskkKDLBigDcdjMFOkZqFAZR9ZC6/gH/iZQL+AQ9Vjh4tbvak/mW
	 ez/S7FKT7AjhhQtxIwx4f/XBymOLkbIpDVKx6SW5l0jHUAskWRcIuaMZnhbkcQ5Rz/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
	b=u3qbmj9PexDOUkNU7gTxOmN4fg9mq6c13uNDBDcPDwx0gEOlclEftIni3MYbpM9MHrsc
	 TQ3HVfItsgm8x7zZKmZIvN6T/dYJICjSHwzMVsWKvpdmz9856lcldjA6KBM3EeVNzJgxQ
	 OJtsAD27ezG66OGW/EYNzy1R5SDAOptXri77nzhKOJO0I+PXj4kqofpUzSDFTq5zs3hpd
	 /Ha+AO+KiGW1/IhZ5SyM8SjywL156cpWxFhi9CLheBo1OzfwU+NHqyxf5WJZ7caaKDPmT
	 K+cdXqcjWG5dXNFAwihcKgdjr8SYOMokjbm7xq1FKSYWwdk4NC45qzhdgUPnXWi1H5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5OkVN2I;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A999606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A999606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5OkVN2I
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3212124eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546929; x=1794151729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
        b=R5OkVN2I0IUxH5Y9qeUnEXX/R7tyZMS+OXoPxprUsKEY9FB3eda+LIkMegmKWR8U2b
         BAgLW2I66E5A8Gj3JGlLEdzTfKTwijMM4ELH9nBwfGA6/POBGKDguEBD598T8zvKGqeo
         mTFVKkMt7+gH+/WRlU3rDXtt0VGs2kWFB22oW3hhWuVr9wOZkiW9EZWofvJX0j3HWXec
         bCN2igKIbBTKUoISMZUydRLwf8EOVXjai0sgCIxZvvy90IaRpF90Y8eY7+sRGsjXVBUs
         AMwC3TGq0fc4CoOsFpTk7tTujRzeYZEumpRLPN7enfaM7z5XO3Z2R1ajODx1/phQj+Xw
         41Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546929; x=1794151729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wo5qks5C3zcSg6+J9xriS5NqBQe487mSK7feaSBUdzU=;
        b=BLrXYlMD87gml01VNpesLQOXI8C57J60iykSyS/qeNrwMGbZjsg9k/z/bcZU34JLFp
         Hyva1K9V+jww/InLgs89bir7Zq2vKIxW/X2Axzv5y9Ab55vOT91c4CZ+wbSyYILq8Lxo
         JI1faAnx3K5HNcslXf6VdQvt2+7TEVQ7a7a1I2ha754Wa68b4xGW9DdH5+Xb0U9+kNfC
         0+45W6SawCOglSLUI5iP/nEEzn9Bto2fl1p2/2QDsjE+X7Zg4K5UOkJnHKwqdw4JIPtV
         rWA6Bp0cyClu7PYR9f48+OEAPK8hsbVGz8bWEng+DyWx+9kWpzZ/FHF7sDtkmi09WAFR
         YWyw==
X-Forwarded-Encrypted: i=1; AKwUvByRJQehr0RzbkOFGQlPraI/2cO7+q+YtIyg2QZhDq9q9l6/7jlPtMo4LkPF7VLv6Fq10uw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpXpMaa1swnjEawSmsIOt6lvLEWTrYYlThIBUhaBZqRoU1F3q/
	rjEBQDhcqAnZjBpoUgUe4VelBdZNslEHsAdXi9ynLtVPdW1+WbBpoWE/
X-Gm-Gg: AYBFou0l52ovriPGEWdjqAq32KHRwF0qiogZPKsQBktVLqKL1z74lyPao3JKgwuCGYt
	kuIBe46dAGus1bLOsUgvWUAi8HXNxp80Lu9KowzDGK+4mw7+KaMQ7v2Gq+ASuTpAiirIsLpO7oc
	oo7pscKbqEtVaeMQ4cFlZvpJBdXfqmMXyEKLeFRSRRPDTX4C/qQBnXknJdIYbNkDcJ17AOS4j2S
	ZQelBVkFT4Hoq3q+jfYD7m6GnoaKfunn760Q7DNOfxTu86dSHtBoEQwsHgrv8aAt8TrLjNI81QV
	hLelUzqkbhOLRPmi6Niv7UkedrKD4zDulhY0Z3cBoqB2sAuHg+Np8cevTM7q9t+IV0XFIUkMpdX
	87AxFhiR9fScdm430URU9PZbLGeccqtAwqinSem9nCJeaNyfQI8hJYvO/NjBTb2beohgOtftNEk
	n2US1UGuUL+vsypMpzmP/guZ36SBojuldWj61c22JVcGlriYa80NCaNm+HycWRV5+nJcV5UUYSA
	kZEcjcZWqrpXsuGNH8dvk9Sf4kdRdLC9L+nT6x7q9HA5ydytJmtW0WHGPO5RCUwqy+xM5KSSW5g
	d1iO28WLpMUyrxLpVVg/ReUGfCEiRTxAnQ==
X-Received: by 2002:a05:7022:5f15:b0:1af:d691:1b4f with SMTP id a92af1059eb24-1afd6911cf7mr4708978c88.42.1793546928542;
        Sun, 01 Nov 2026 07:28:48 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:47 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 6/7] KVM: PPC: Book3S HV: Fix error handling during vcore create
Date: Sun,  1 Nov 2026 20:58:11 +0530
Message-Id: <20f3d8cc8d5dc36872873cec4c8cb48a68e46354.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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

kvmppc_vcore_create() can fail and return NULL, this patch fixes the
error handling when this happens.

vcore and online_vcores count should only be updated when vcore was
actually created, otherwise it's state gets messed up for the VM run.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..e39491dfb975 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3090,10 +3090,12 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			err = -ENOMEM;
 			vcore = kvmppc_vcore_create(kvm,
 					id & ~(kvm->arch.smt_mode - 1));
-			mutex_lock(&kvm->arch.mmu_setup_lock);
-			kvm->arch.vcores[core] = vcore;
-			kvm->arch.online_vcores++;
-			mutex_unlock(&kvm->arch.mmu_setup_lock);
+			if (vcore) {
+				mutex_lock(&kvm->arch.mmu_setup_lock);
+				kvm->arch.vcores[core] = vcore;
+				kvm->arch.online_vcores++;
+				mutex_unlock(&kvm->arch.mmu_setup_lock);
+			}
 		}
 	}
 
-- 
2.39.5

