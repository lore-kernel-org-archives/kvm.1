Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544442;
	b=ZXvXqFGj6o14RHsUux6f378zrHyhJYdVFuc/F5/9plSgcQNgmViib/sZVxfgJGKZ+BFp
	 R9xV4hzwYEfIQe5PikwHN+I3l3ixNRfmnEnWBxjc+cZnkQ7kFp1QhyUefI2dUMJKHqaYm
	 xCAdz/4GEbTmZt6tbrB0mUUQet05867+RRrSev5RAfDdlPt+5A54EC1mQ8GJJ6qrw93Sb
	 4H7N8JAlQO1UVzb4sAUZ287euRuQQYcTRxE3F0gEZZvMGQM6VNQFZ8vmKxlfmlAxdLLs0
	 /pKEC6kFvve9PNZMUoj+TxpjqDkkltZTawxAoMB3bZLaGCA0gALSf7AzfQ92ZHWi9dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
	b=1aj13CdI0KmNLoT6sNTvJpytMQuTHevxSU/z/XGoYLmByeRV5Y7ei98otbHTJRb1P4rg
	 zkVf8hXX1UtqIyitF0SDtuPSta3KqHIy8XyrMGznl9fi6duE3ZcJZ+dFfdN3ZQEj9PQgf
	 0iuHOW357BC8Fz6XZbCiyoeLXFNOUsRVHHp+obde5DD/ftbu6F8C+FhV2xq61kswXypHz
	 NUSDWccpWfm3GJULj4GJW8SVkxenC/UO3uEh4VkHSCVDqPDuHzrb2cyvuTr5UVye/XQdF
	 wWcYU0rK9EJUurdqxqEnjLgMvixeGtZ/P5mUVKyZhaL4vKeozDeFFASixb6wrGkaKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKD7BFNI;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA4606A326
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8AA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKD7BFNI
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35829219da8so3848387eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544441; x=1794149241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
        b=PKD7BFNI4DNeis1dgdg478g+scUCiXpDmUnntj9VD1vWUizYpKRmzuu+wO7bGGBxjz
         v5HK/S7HFJs70Ff2txmHYCXi1H/CrgEwtwdWoLLCvT1llsTX6Yv5eCuhe1xW3BmQBl6A
         bKzgM8GDSVh5bN8ZmouOTE546aRdkJnO2hKx2xT5OOwk2BgKjRApyhVarjAO4MfbjDDG
         58koMXA5VRgxjo2DSQ1RTIm3Pek49/8M6CUggDc5u1RhsucaO7/e1RMjf6G5OrQVyJZd
         /cHnguz8c8pTRYwiw+x800hOBIiQnWyTgpnuXsbso9sm2SEkI4qqYbTeIaeb6xRbmAKH
         YEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544441; x=1794149241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGcwHzUCP4ZDgaGEqf3mJTvGTZTE+h3JfZ8GLOdbBG0=;
        b=w/Kr5v4JApMYl52WFAzKTwhFBOlZhZJQNnIwgblfVymABUXgw2bYona2OTEhkec/j+
         qTwHkrc5j7IryiUjq+rPNkS3Hib4vagrYDwpIhTcYnPZ+wEIyfQHrEAVqADqUffByxCs
         1VMWP54angRsP9jKJKnSlmaYWKnhFo+MB8U7kUi+XYRywiNVe2ArbzBqq1riPZk0H2Qh
         mTS0bCCPiEX92OXSrly1IDIbGorsZcR5UMWC8LueiCc1axS7R3mYitwEYT8B7MfcHcZD
         fpIBUoiTaeSBXOK/qlDGyLbKGkgNOD0Io0lJ6tciDgxCru0qBUCsqwDlveMwpZJI7CG1
         xUeQ==
X-Forwarded-Encrypted: i=1; AKwUvBx61mSu8ESUtx29V62abgQ4mbrd9ZVRVBccusDLjkDfTAMBqhMRDywF3lGMaSjbm082xIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKRXT5+wy3CLhiYMnikD8GIjWq5wgP9+Zj4gpS1QKq1Yng275X
	RY6PS6+opZMvoMAxrD3RbCzQqcNhq3VQB8sNYaws+Q0DQI1sDDubX17Z
X-Gm-Gg: AYBFou24kx9UZqgUNCXD49NnCe8AledWeLfslWxjAIrDsfJ8YfPaiJfhWR946nQGNAo
	AUmRQYKj84N5b0xW6xKHSG24VHTihnJwfX4L95XpiHzMIGY359k0RhdjKnJkFpnNuG1M7qhV1hK
	UEh0hPKUqrR9JKqXrfCZ1tqmzubFsJ20vQqPStzSBk6qJ0JuQajZhcEUY05bw3m8tsTnHogv3NL
	QhFDEsCrImFYFqmvmeF/cQOMF1ZxqqVU4BJb2I+E4xCoqMsS++eCaQ7zuyw5S2F/jsdJAZPXUhr
	xCPYqbZJusNd5B6A34hLajEv99J9cP5i0e/1fFCV9yAgofzXJFHqiI+79myZ/nw/vW2ELfFZC4d
	R1fTrYXV701vYJfyHBJ7SDIhH3e/XC9vhRFw5cO01lVzZFk6OBuAUJ6COrDix0Yuz5te/jK2iCK
	Hl2O7FmjYhaz6AOxb9xNFHStiw75S2wWC7o+F3dJ0DeUv2UbJPE847r8WGU/Tr0Fkvyap3zR95H
	mJoA0HORGZ8RG/YWvjnx5/4LudEtE8xR5Hfs0lD5ULd3Mm/S4yOlpCZQByrpaXbga1+TG9MezjR
	VI50ywMTlTWyW9BYNpR0XLIrRKh+cFwUhA==
X-Received: by 2002:a05:693c:8211:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-36a42340d04mr11570265eec.4.1793544440908;
        Sun, 01 Nov 2026 06:47:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:20 -0800 (PST)
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
Subject: [PATCHv2 7/7] KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails
Date: Sun,  1 Nov 2026 20:16:32 +0530
Message-Id: <2c9913c7051ddc867439d2b6d2d485d3df83a31f.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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
index 7975e5de89d0..a242abaea357 100644
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

