Received: from mail-pj2-f35.google.com (mail-pj2-f35.google.com [74.125.227.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1A4FB9DF
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567671; cv=none; b=Mv88T0rrnU4Ei58C9Z2ZsIDrjbNdKMb/mRmMNZbo8w5/arZcfDvlBvet5UiZPuyI7/shZzqnX/yteP6tFD4Z2vUd0pn5RNvIZwU3+bdnDzfbEgCIAhmVuO0ZOgXQnXhx/OLHLpy4y8KfGZ8iJMnB/ihZByjOh389w4YTMAiej2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567671; c=relaxed/simple;
	bh=2ryGNl6oXheRx8aq0X55UmksbIPQgAEgzorLvgUpZ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5G2Rzortb/gg416alwbWTO1dH0uxDKABwURvcFKJNVr6uHkM28Hh5qTYv8NeDIESl5nCg0z+trZHi0HENh7x0w4RECJL97hxJ7t8s7O4vvdVMI+37FO1MOQEs+3wv76CnNeg2qfqzb8p6IVtzHxVs4jQfXmIidOTH1ufG3s/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ2ObqZ4; arc=none smtp.client-ip=74.125.227.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ2ObqZ4"
Received: by mail-pj2-f35.google.com with SMTP id d9443c01a7336-2dd77300825so9452785ad.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789567669; x=1790172469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5Rra/PVcmzax9enHjnZo2f+/CC6GR4PQjiSRwVy+Jw=;
        b=SZ2ObqZ45OQX8DdeLymePHA+12+hn3haVx+uRwnbUQhSBkTsZGEKZbc7UR4uFGrzNg
         H+Tgjzd+6BSxcJA9Zl4d/5cj//8/EJGFQkpDqHrcQJe0/QcUP25DHf8vyYjFlxD1U7iX
         TCF1EdVgZZUPIEWIMuEm778jxImSCjEX1G8U8vTYToASvKyXuaDngld/An9gb3VAZEEG
         +zoYFS/0hHwf5YhLGRDdQBWxg6q1w5N6igwxmhxhLL+mdha6AlsSgWfgMeWq5d5ZxB1C
         Ryzwu+jpKKjNq5cUSYemTjrymJgHKevXV4sqVvdQKHIzaE2zTsA8LZQAmvjQ1iumP5fr
         rKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567669; x=1790172469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5Rra/PVcmzax9enHjnZo2f+/CC6GR4PQjiSRwVy+Jw=;
        b=D9Ws6OhgjDdawLF7FkRJieWxGP246NofWvafWri4e4Bq/30a9M8XJGyEoeLuKFsd2e
         NLHzuc7iMRVKzOOhsflTqn5xE7M9GbChzCN9jOYxU3uVuAG0bfidBceWXQQLFnVo1dL3
         V4pIwad+g/mQZYIqbmeQvdceqQAP+q+ecxrjK2YQyyDbIn9bS9aRi4iVIby4v8hav3nR
         4PEUeSxnnu2T8jCsdGvz47Iuirx5zz/um+NXmzX2ewmjlMqxDkW1/ZpMZKmxa9oexkZe
         0Lgr8bimqYUEG/H6qjjSgiCrcLHCHMjYbra7vXupbkOqQyzVze1AyCd4wBZ2JsAvjgU7
         ivgA==
X-Forwarded-Encrypted: i=1; AKwUvBwg4Z/0qti4ZVFi2vIDRohUGQg518+3fkCWAHLxKUzRqFMJJghJpiyCUi9GDsSlt6duDTs=@vger.kernel.org
X-Gm-Message-State: AFuF++mlC1jpYGHVk1iyKqoyyP7JCe4TRnfUrIzJ8w713BuogMRciRnu
	YRkD2vH31+6R15mW6FtWq2hihSTX8NVCra9HpuI1oHgVWFsv+pfBwc0t
X-Gm-Gg: AYBFou3hsxTIdtPHXokgO4nLQSP6WV9snDUlcYX0eyyHXkxZsF1HC1OxutTrRUdRP92
	rmDnQXORG2CJOYneV6gTGEq1uvokDVSdPfG4oCxLdwCgYErcOfgig486Y3tf+f0Xqn2VR/GMlPl
	MUGeMxZbcxh8dX3m4zuArEFtoeqHsYonmzV74GxN3HzqBvERvAHNWU9RYmhkHXdJUnaucat/z4X
	DJpcOBtU9ZQ48+9UFfzh4BZ+i9iKTj9x+QNc/azynH9HAdxfMUprjTkl7jSTaD+i2+UIDqf8IG3
	B4qLKODXe9rWVBZC/MjXtwEmxWIr+tOgd/N0GpYSa41zV96DojcBiHxrkNU0XMJ6dbGNA8uSHEk
	2+Kll0+mxD8O1AV5iCFwjmXGW7OxRC/TSdJWowOPmRgog26CLdKt0k9ufR+Yr24joaAG/PVltlG
	K+KDQMJS1RpOYrHVF/pjU+gMcAWf/2GjZsJRKShmuclX+J8uNnQ+AHITPEzlX2Y+J7sV+ISyAmw
	sFK
X-Received: by 2002:a17:902:d4cb:b0:2dd:88b4:6920 with SMTP id d9443c01a7336-2dd8e784c69mr58010935ad.22.1789567668803;
        Wed, 16 Sep 2026 07:07:48 -0700 (PDT)
Received: from nixos ([171.239.145.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89edd1d5sm12622275ad.48.2026.09.16.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:07:48 -0700 (PDT)
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Wed, 16 Sep 2026 21:07:42 +0700
Message-ID: <20260916140742.636708-1-kaylovefoss@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
---
v2:
- Resend; v1 was mangled by the mail client. No code changes.

 arch/powerpc/kvm/guest-state-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
 int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
 	struct kvmppc_gs_buff *gsb)
 {
-	if (!gsm->ops->fill_info)
+	if (!gsm->ops->refresh_info)
 	return -EINVAL;
 
 	return gsm->ops->refresh_info(gsm, gsb);
-- 
2.54.0
