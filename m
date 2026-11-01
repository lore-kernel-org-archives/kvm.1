Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546934;
	b=cjxRxn+6SwBil83SJ0V2r9hR7b1Ka13WHa+z/4uDnYywaQXgejKnYrzWCS3GuEmMzjU0
	 ueE97Bxv53Aa5A9hwNDxNosgf51BQShnOMwi809+ZoX9R3/4QbnQen7WB4j2Pc7SKSN6B
	 LD4I7AT91KuL32lMf9igeLBvl3xDZdf9vHSG1Y3x69AdhhKmnfkGUIiSWURYz0suNHnZ3
	 sNDWo5shQDRiGc+myantRmJaQhBeGo/6p2dfuDPH3iHczFNKb+dxSV5YUy3DdhdD7wypX
	 +nT+CROEKIx58oYEZ4l12dY/BJbCl0lcWMCYEEhURqtRQPc9di5ATg2N2wt14KNaQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
	b=oolTQtZWfi2dGD22AAsDulOb2/C6ogj+9Uw8fgW/A4EA5jAEnf4u4JBM7Cvhh18HqB5Z
	 52m0dT1uedJY87Y7ijpIh8GGhpB6Fq5myBE8Te3SahENntla2svqnvxQvN0S5juwjWKJy
	 PpWq9GJ7+Z0zzAsZv635/fdqGaj+IbnxATgq3bVot6SE3BCGWZ0kZ1YpbDN+t71yZVmra
	 5/haH1yPy7BoqBI7LlDrnHNu0NPWPe36CfBqUIX4WVwLtqLrkGwfzTF2QQwe8qPOKWvI4
	 Xw9hCER61givwa7BpAsYhktX215e3+T4mNZdIe6/Z2TocipUE7wv90OrzR2VG9wqOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ybqnyvdm;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1820606A32C
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1820606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ybqnyvdm
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35829219da8so3871388eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546933; x=1794151733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
        b=ybqnyvdmX+JT+N9Z4qS5kDP9PZ+WEzSsrDRXBhesh/kajYk+CA5jjrdShNzmZJyAM0
         DI+uTYHJ9VsZ8o4+zieEhjFQHBlH3aW7lULFqi2CEib61jDXtCg3yoP4FsGBLvuKUB1B
         EcD1RbSk9KsbTIyBNtdG8YpsQ40xKOnsiqlUxP+k2vhJC8KA46EivQSrukg0eRJpq1fn
         6yzEG0we2CnB47bJc2PH6ITwQRkreMj6hWAcgSkHjzRDxw4HEQqIbuWrxCUQQqjr2PQ/
         wCUU0Cb5vqdMcqgZ59J4ptBXzu/6T57XY1C7/R2guibScY+vis9jCPpkGKRn1fpA8kRD
         NlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546933; x=1794151733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8U+w5fTrGO1h6dmc4Lc7LqvLyaXO5MtfIamT3kiNq3A=;
        b=lTy0B7Ugx5uhi+BJB9ki/bhHntsFLKY/B34xYuplqh494cBn7bgKgtylHCX7V4ZEKq
         RuWBL2Uk47AdgReF0454z3+pBIHAx8iCQFnhSSsuHQyAezH7fqFtYF8Lvj79cRbqVfpo
         tLT75ZiRNZ8EZWy5hLsV3XdR93QrpHHdghFN0CJ2HkCmokAqY/YsE2rkCXbrpuL2+1Wg
         6CHUJszphr9IIjaC49DY0kwXdr/9MgNspvmTxPktKpCptokEmHqsTxdqglePBhbepPLk
         U1/oZeWh2yIFGXQQuFqo3J4hh/GCAjP3LbFQfS5jnsgtfdxg1og9D72N45VB6XlXRVdI
         cXSA==
X-Forwarded-Encrypted: i=1; AKwUvBwk5omeXZrfQMBibqavugr7E63JiDs6UdV0c91iKdWf+PBY5F5BcOyi7vXu17g4MqWxPzY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeKfTjrk0h0I94Bp+vFu8f4hvMbPydAZx7qDa045g54HgCp2rI
	n7iAKBvZvQ4/c17qd3gbuTUpOlg/MrOF6qkKmzVApBYCjGC2UsD//szQ
X-Gm-Gg: AYBFou0Kp7VRqGO54gF8Qd6QBjDeOh/ltNgDc+fZihW2FblyhjMCjdX+RwFb/PcV4/Y
	vjDkU8tEcPd7UXK0ZdF4nO0l08dYM9FlbIHXtxRMbZZqRu282uVbrXVXsnN9J0e+5XS2KRuJkit
	HjXIe2RCcLBUD7KvMnfD+jlkhU8j9AMArU0+5fVcUJ2hgMqd5Z5g9Wf//mko0qiI7/F5MunXK2Z
	xO+LWugTrqFRUTYRRwO1iiqpDHw/+d/v7coU7yRq1u34OkdeYFSPMQyTFmfXvacziMulJfOh3tR
	5/JvufBG+VXjL+xEYthd/45tS/HERZ3wHWecm6Cw8zG7BWqVifYxrJPT4WcnD1DpnuCLbbhSIXz
	O/fAJ/tlNXrdGHlPmEvotx27hYBItY6LnM3ARjtGeFVjTlW7kB8RKmMM/8gTVkqBIWXGfyZZY/T
	ubKvO6ENLIpqneMilmEd3TbRWzR6VT6lYsY0ax2OGtcOl6wcRcsbHo1OMEfN4tM6LHHCAKSY+y2
	ocOGF31JdQC5oQsTXIJms86y5Gb0flJ8gkmNRVAvJCKARdFpG60BdT64c/2uajEu74Nc/vQcq4j
	GGb52rISckp3YNl/g/UIDEthdoaRaPz7eiEC8g51ShXCSbI1tlfsfl0=
X-Received: by 2002:a05:7022:258f:b0:19e:78fe:9d67 with SMTP id a92af1059eb24-1ac5a680801mr14363449c88.9.1793546933035;
        Sun, 01 Nov 2026 07:28:53 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:52 -0800 (PST)
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
Subject: [PATCHv3 7/7] KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails
Date: Sun,  1 Nov 2026 20:58:12 +0530
Message-Id: <082c338c69773a73a48cd4e0d0885ee0f6ef5326.1793546707.git.ritesh.list@gmail.com>
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

On a nestedv2 host, kvmppc_core_vcpu_create_hv() first creates the vCPU
in the L0 with kvmhv_nestedv2_vcpu_create(), which also allocates the
guest state messages and the run input/output buffers. Only after that
it picks a vcore for the vCPU - which can actually fail.

This patch therefore takes care of freeing the GSM abd GSB for nestedv2
if an error occurs later as part of the cleanup routine.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e39491dfb975..8de753e302c4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3099,8 +3099,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (!vcore)
+	if (!vcore) {
+		if (kvmhv_is_nestedv2())
+			kvmhv_nestedv2_vcpu_free(vcpu, &vcpu->arch.nestedv2_io);
 		return err;
+	}
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
-- 
2.39.5

