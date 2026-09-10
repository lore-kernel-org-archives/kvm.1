Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58F235358
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011425; cv=none; b=t6xGH36ncbklemC2vUf3DOTy/2CrNlnt1F9XaQtPfe6NKFFKKxzaQ1kupo0j2GGJEJ35EsaMuDMJ1v1kwq0IhJ+JiiUq8kvft0v9QVGBMd4NKHlEKSzjjWqf3VmsRaHKO4Ki9VA+1D/Dz+gKM00+ACaELzWbmdrMil4E7ne2Oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011425; c=relaxed/simple;
	bh=gBPgpvXIFMEkkeDLClGuqvq1+6LResb8DrffoRsw6c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KbyoBKmtqMA3ty7C1ftgCjQ9tBrICqCPTJtsmNM5+iEizYaXq9bw7gCPtPNrDuxPmfJl7oOKQjqB2TlV6kHit+FNouurrgyRPJEeslRKi2buiNLQrZpwK8eTzFWK689Rs6Z9w/cEFB6ujKyJQGYYCwuQm9EjGRd/ww6bIS8H4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLuKirmk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLuKirmk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so64862825e9.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789011422; x=1789616222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8ZWMEFHQbcH0tt4vDOyvt6b0NrgibIrdXJYwFIp6tM=;
        b=pLuKirmkQeqelS81KDqSIofFIHwomEede4FoNH2pDKnzOYbxTV1Vb7gYqYQd45AxNg
         Z9c1nVKSp5YFu4iJe/38gPloS7+bSLp9SAw46/cvdvHXPPHASQ8rpxv9Nw9KheffHznO
         /fpb5UuF3r/k8v4vzfsDDJNCdadkYSgRNQhgiA1qgvSsRjVVIjMdsCqhzHr4Pyx76SbN
         m48VyVXAsr5a9P7R8qn8HcX/iWtoWJdVXw+nJm0cDI2Ev/OKuks1TkYqEOrgwqZYZVYl
         3CLmNAcLDvjxvM0ljPoHBonUhXwtWQTWA6Fpt3LA1wVjsa1ytumZ04ur/OfwAN1AyJGp
         rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011422; x=1789616222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8ZWMEFHQbcH0tt4vDOyvt6b0NrgibIrdXJYwFIp6tM=;
        b=fodWpsxnXTmvJ1TqhqD+AAwDOvGuJnz98fl3Y+SjoZlwtjqjlWBNFHroS0Jj5AFn81
         /CcPXVqUmPcPX7uIlYv/DOtKVbhMnLeTDJvVXRFrC9XjRK4JZNOdHW2+IVaB0R3EorM8
         dBOLE3t4G3cN3iISQdklijcflMaQH5BcK9UKfaWfPJolto9uBgtQhzws+M84ZJMRPjtm
         qJ1RkgXW8yY+dev0zfkWpc6Ana70WEaIQG6+nQ5rDGfU5NloK9XAmWJhcvRg+a2kuCNx
         j38BJ64+t2JhkNcxdrXp+4tnqYE3F9WBCXS97HvnbeEpAc0bUqwHBwuktfYUE8HraweU
         zLqA==
X-Forwarded-Encrypted: i=1; AKwUvByRI4zdzqxrjjK3/Yg/KtEvHCRqnivMmz6xlWvpGzT39TC5oLr28vJIekNaeNuqy7pKGqA=@vger.kernel.org
X-Gm-Message-State: AFuF++ncNgacdYXjmRH4V5LX7VmlhImyGpLo4QS/I0/VRYe/AbcTBnD7
	+lundplHP9DGi1cqM3yF8gL9bqhA2lh2Thc6rwuiKp4xvvQPNRC+4qG6
X-Gm-Gg: AYBFou3+rPogf6s/fnrCMfqIHNm+S5sn9KgtgOB/wumiml50j7mxmoUJt1K09J23UFQ
	AhI+S/A5pGr9GozJzIO8AI0Ns01gp4agQ9OEy4Vd+YscUyEAivmqVZvE7WLfn9jlmyGGE6oO9xE
	VpIo+FXcw+EZ3okNc0adea9e/AOvE4/alnHLv2RdBMeT4xDlio+WqX+t0tvEdeIs0GxG7ThVP5G
	qwawoumZKK2h4tHYfNCYrkoM9Uvm6NLHnY72T5xsZsjr2qj0lWMpZnq2+m8Eim6sA0Cu5Rn14Mr
	+xef+pzkwXG0R4S/4KS/MPWDJQcC0+KK7CjJrzPPdtAg0DzAQpmQbhNOS0nj9lBndWXNu4ocTaa
	AzsCYqYxUw5Za8/RlwL9Piye4M9yDbh4/sAOKzRIKHWZRC/d3YrHfpY8nSjWL266KOx1MYinvgE
	brbr2ALyX7vWso53t17DMJSAYnCH/HRLxuq80AEabRDV586Ao9Gbk5EKlQoxTJIwR7/CLsnhzyX
	EktQE1K3TK5OvtMnVkYe8TMtrm+pZ0fZqSzmTbD6Z+/ws69JnBOTxMPZnNUAj+WZ0uITjiWSIRO
	Q/kmAyfN4sYKTNz3Kjya9qkc47cE6cQajZeGRpc23ZmLnl377drDTPuKp4wwXTWhiyJTvoXECcF
	zfoUqQ6P7tw==
X-Received: by 2002:a05:600c:4e16:b0:49c:fc6c:bdfc with SMTP id 5b1f17b1804b1-49cfc6cc01bmr341548035e9.19.1789011422051;
        Wed, 09 Sep 2026 20:37:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b3d9-b901-0402-5aad-0ef4-88ac.310.pool.telefonica.de. [2a02:3100:b3d9:b901:402:5aad:ef4:88ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b726f9sm34506475e9.0.2026.09.09.20.37.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:37:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jordan Niethe <jniethe5@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix guest state buffer kernel-doc names and parameters
Date: Thu, 10 Sep 2026 05:36:55 +0200
Message-Id: <20260910033655.16127-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several guest state buffer comments use copied function or parameter
names. In particular, kvmppc_gsm_for_each() describes a parser and an
element argument, although it takes a message and yields IDs.
kvmppc_gsm_include_all() also describes an ID argument it does not take.

Match the headings and parameter descriptions to their declarations,
and describe the parser argument and vector output with their actual
roles.

Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/powerpc/include/asm/guest-state-buffer.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/guest-state-buffer.h b/arch/powerpc/include/asm/guest-state-buffer.h
index acd61eb36d59..95d50ec7f2a9 100644
--- a/arch/powerpc/include/asm/guest-state-buffer.h
+++ b/arch/powerpc/include/asm/guest-state-buffer.h
@@ -224,7 +224,7 @@ struct kvmppc_gs_buff_info {
 
 /**
  * struct kvmppc_gs_header - serialized guest state buffer header
- * @nelem: count of guest state elements in the buffer
+ * @nelems: count of guest state elements in the buffer
  * @data: start of the stream of elements in the buffer
  */
 struct kvmppc_gs_header {
@@ -779,6 +779,7 @@ static inline u64 kvmppc_gse_get_u64(const struct kvmppc_gs_elem *gse)
 /**
  * kvmppc_gse_get_vector128() - return the data of a vector element
  * @gse: guest state element
+ * @v: output vector in host endianness
  */
 static inline void kvmppc_gse_get_vector128(const struct kvmppc_gs_elem *gse,
 					    vector128 *v)
@@ -849,7 +850,7 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
 /**
  * kvmppc_gsp_for_each - iterate the <guest state IDs, guest state element>
  * pairs
- * @gsp: guest state buffer bitmap
+ * @gsp: guest state parser
  * @iden: current guest state ID
  * @gse: guest state element
  */
@@ -866,9 +867,8 @@ struct kvmppc_gs_elem *kvmppc_gsp_lookup(struct kvmppc_gs_parser *gsp,
 /**
  * kvmppc_gsm_for_each - iterate the guest state IDs included in a guest state
  * message
- * @gsp: guest state buffer bitmap
+ * @gsm: guest state message
  * @iden: current guest state ID
- * @gse: guest state element
  */
 #define kvmppc_gsm_for_each(gsm, iden)                            \
 	for (iden = kvmppc_gsbm_next(&gsm->bitmap, 0); iden != 0; \
@@ -908,10 +908,9 @@ static inline bool kvmppc_gsm_includes(struct kvmppc_gs_msg *gsm, u16 iden)
 }
 
 /**
- * kvmppc_gsm_includes - indicate all guest state IDs should be included when
+ * kvmppc_gsm_include_all - indicate all guest state IDs should be included when
  * serializing
  * @gsm: guest state message
- * @iden: guest state ID
  */
 static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
 {
@@ -919,7 +918,7 @@ static inline void kvmppc_gsm_include_all(struct kvmppc_gs_msg *gsm)
 }
 
 /**
- * kvmppc_gsm_include - clear the guest state IDs that should be included when
+ * kvmppc_gsm_reset - clear the guest state IDs that should be included when
  * serializing
  * @gsm: guest state message
  */
@@ -958,7 +957,7 @@ static inline int kvmppc_gsb_receive_data(struct kvmppc_gs_buff *gsb,
 }
 
 /**
- * kvmppc_gsb_recv - receive a single guest state ID
+ * kvmppc_gsb_receive_datum - receive a single guest state ID
  * @gsb: guest state buffer
  * @gsm: guest state message
  * @iden: guest state identity
@@ -998,7 +997,7 @@ static inline int kvmppc_gsb_send_data(struct kvmppc_gs_buff *gsb,
 }
 
 /**
- * kvmppc_gsb_recv - send a single guest state ID
+ * kvmppc_gsb_send_datum - send a single guest state ID
  * @gsb: guest state buffer
  * @gsm: guest state message
  * @iden: guest state identity

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.39.5 (Apple Git-154)

