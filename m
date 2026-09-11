Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF537F8C4
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102623; cv=none; b=cYUr31R0ZSdGLUn5TzjhcgRg8DD6I13OX4X5MNrOGKfKjlYqq7MycKv/Hk9HE28aEPLYC5SJGu2P9mO9q4qWOzRHpB/wJF1MqhV09VbZ79cLO+y7FRPy0xNg6R94Q3mhMUp8mN4AwsvrxyL/8W8PvesY6XNA30/Hi38ptX6LyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102623; c=relaxed/simple;
	bh=KEpBOaijdHjRczOFG95mGYtz+2slQUVveTGFA7ZfiKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lfo+2lHeGQm+3jVQMudiJ5FmXIHaTrwcoTTWvbjzipSEYEm8j7IWjPRlpeTmUUr9nTMfNf1xw8vL/HwyS1tKbZe+5gm/YzX2E5nf2GvPz3O+oF6uokfxfMy/NUaPc/xgoCiPHyX4/yT/ojFOVwV5fhR8BtF5dZZveoyrRfz2K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdKHO6YB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdKHO6YB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8690079f2c1so474735b3a.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102622; x=1789707422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sS+NnjQVu7GC8limcyn1Ri+jiI6RVFD9z3vzk1/dCDI=;
        b=pdKHO6YBbs7hTAYzH74yd1R7XZxxth62037NVQhTlfrn0xm/A4M9VxbUxP/SN7jogl
         JACetZsRbEBwSW8sXB3dXOd3Ofp+4ANndSk7CyAlMbq1wt1w1nuiDuUfCgv1XBcLNI6T
         KIKzeQYmV2Ti6f1I0hWSW34hLy+4zzL9fRT/HLXlDNxWZgPFj72IH6cy/bYNYz9K+XjL
         zo61/IhKLbEfCfLO4tpXfBYHg12Hmcfb0ddb9Cd6/mK6eTzBpO7ZOKccRZSjwM8SRBh6
         xyHsghs2yH4ymDNcD2Y94ftDgSoSR4GhK8mIxV21FhCPvTzokDhMnVSBMyDfHZzW37Kg
         0Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102622; x=1789707422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sS+NnjQVu7GC8limcyn1Ri+jiI6RVFD9z3vzk1/dCDI=;
        b=MmxsVX1CstxBWunMdABX4VT5eAb/jPYJsB6+zLif7N/RM/pq7dnyjXarwAtBjPj/vu
         hOwSxIS/xOLwlnhHb0xwBDi29jdONl68BzlqGI+XiUGiFadb0NONX2rxveQnCBkgP9Pq
         0ycgythrgdhJYKW9QGg7ymqSYcJOu6263IsxSDbZKTCS/ycfNLpyJZ+bc2WzROAdAM8i
         7ASgJpILazDjj0Auin6smujiOIZAFjUNP0PyTHfqYsV51fEOUUD61poGTsdKdUYv3kKv
         l64s2c/YHfpiplOLwVEITdhM29Pryq4+QXvNKgoNVMpP+q5mYqXTzA7Tklsw5cPOdc85
         08eA==
X-Forwarded-Encrypted: i=1; AKwUvBwxm/g6LdQ4VvL3TI/BI2r9nBfCvhIEGP4TxmO+p3tll9s7/0wGWz5vN9uBmCpyOgHv1as=@vger.kernel.org
X-Gm-Message-State: AFuF++ks7yfoJUqq7gsjHvJ/NReZEqqg5W3L689SFD38oa1EhJWKjxY3
	774m70z/P7brPh/hcpPXSBxR1RDeIN64ZU/a6RQmgSIMbIfoxE4Fzu9i
X-Gm-Gg: AYBFou2SP+MaFOLLbBHz9+UjjWo1DTMLWjZpzqvplIyeWxMwttfLiyj+Y8DK+XXjfav
	GH0iw1NInMZwVQr9GzVYFUSvikP63WX5LabP33/fyu+LbPP7C7+DVxVqQ0dNqK8aYQ7DJw8tuvv
	bwuFhy9Faq6TK2hJ8qP1vpLtmofQBiwb4Rea9jv/CtMyWz3z8VJBHpl6dONQtnJIaJLF7q0Ryt/
	wyOkkosBH3E57/Db8EAr8nJESl/tqTrnsOvE8OmkEtCTmerzUvMTPVJ4q0ZPjksd/JWXwk/h0Hf
	i0x7bXJJrLdKLxM5sholeDKUEhzvYcU6SiZEnlVI6FqHyZf7osjMbJIVsxnrcsEtSP0m9sdZGkZ
	7ZQhP1ksBqLrHOF6eIfivnezNTzSUu+F7EO4v2UNIPSx3GHgwkbJ/B601Vag7BwJx5t8lzYNI8E
	8VpG2jK0u8EGATrCGAUp5+n6NMJdW/jvVXYIOC8FNuogk9D1TYxeACCnogQQ42so3yzeRM5zM8s
	6Xbbjac8v/q5nMNZVMPxeN75N+YclgKKkoeg24GLOJcanSGHKJ7w6TKxsT/aweqSwEbxTNP
X-Received: by 2002:a05:6a21:6f88:b0:3c3:6f6c:aa21 with SMTP id adf61e73a8af0-3daed20aeabmr4999468637.11.1789102621767;
        Thu, 10 Sep 2026 21:57:01 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:01 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/3] KVM: PPC: BE guest-exit fixes and nestedv2 vCPU limit
Date: Fri, 11 Sep 2026 10:26:44 +0530
Message-Id: <cover.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These issues were identified while adding kvm powerpc selftests infrastructure
support [1]. Patch-1 and Patch-2 were identified while running the selftests on
Qemu+TCG+powernv+BE, while Patch-3 can also be reproduced on a real pseries LPAR
with nestedv2 capabilities.

[1]: https://lore.kernel.org/linuxppc-dev/cover.1789097569.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (3):
  KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
  KVM: PPC: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit

 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s.c             | 22 ++++++++++++----------
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 arch/powerpc/kvm/powerpc.c            |  6 ++++++
 4 files changed, 30 insertions(+), 12 deletions(-)

--
2.39.5

