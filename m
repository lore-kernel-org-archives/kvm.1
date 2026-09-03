Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C19263F5D
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394591; cv=none; b=ZrDH3yMgBWey6p825vd5EG86Xe782ido2XI0N4U1Ef3hxrVq3a5109xCCdmaZYsBo+IC/ITgL5Xro5P2Ine+4/owgcZXKMMEgS+K+MGkpP5c08Evvqt2Bs16sfGRZ1LEljJz4ptB2jeLLbQJAt2c7Pfzf3+nPMkBygmze3to3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394591; c=relaxed/simple;
	bh=hrCUfZiWrw9ZwLGPWRegXU7yNm5oMyEYfmcKkafasI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhhUYa0Bs3Mqjs6wJuLXF8wO+t7B5WAFWAY0OkibkGVxHWXBPKpo+GJuskO7PM6u1yI0dfEufuAaj1PTUHpeSVZEhCzvI/ER15eWb9X3jok0qJULk9PZESOYp7dmkR3LfjMc3NgtgwKzLoYCJG92+LKQzx7jc2o9/tE6HXzvrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TN4RKXPZ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TN4RKXPZ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6c166bafcso26337695ad.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394589; x=1788999389; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sf4kQQtnclBVJ8kleYvL+id2aL4kDG4DntUcaSprvaY=;
        b=TN4RKXPZHzssHKAHHDQtnGFrx5dn69Zh+6uygQHUKc0Qnlqth9M+O9Gwg9jWFgpXa8
         AMGF0mzn8Vw3OLwP/75D/GXfOHhcuDlZn1Lbxawn4/irDsLs0lxyDLI5ShQP5YIn0f8w
         ZeVlajdE36+EX6Mq2Fx+3723eGnypHskqMUoXJt01ci9nD5z3B2lD7VGNOGWNPuz/hM7
         yDpFsS9PTueAbYBI5kcnE7Qfi35PvHt4nTTdqWX/IixZcUmQVJKifO6X0L0+zXPIUvEG
         VevmsnWaz7PCPwAnJ6sRWlGdh0VglBJQH+cNFX5t2UCTxkYFlYshslHaegrnrY/G5I91
         hiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394589; x=1788999389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sf4kQQtnclBVJ8kleYvL+id2aL4kDG4DntUcaSprvaY=;
        b=CdBnsTGCfv0fsDNpf9YDU6BFhMcctj7Ylk7DXBfk0L4cZ0PPN2wCNqHAcTESTCydf7
         dYPnMaIbrkCDitY2tOtNjSJqLHScZQJAcYIuS6SfMGCkH5sFIDtsZET/LZQjLIB5SfwT
         Atr9NqV0Br0/n+lIWQVwt9QoiZ1nrgnKUcLy6xZIq321fGnOo8jJp31qr30KcGgYSh9B
         EHnVrevRSzMl8TNKqKJF7LHQNqySPYffbL3QHEUVr5XUrBIT+lo18TLXxEsYr5IEEuT5
         Y3gE5wUcDKwLYIJoLOE3AMxBGrh4dfof/ihG+GFe6IzhsRkYYCYlUKhXPNBvvuJkMPMD
         cR1g==
X-Gm-Message-State: AFuF++mf2qrlJpae6vFoNuHZOWDUU3QTTNdhI5XZDDAJEV77BO0YSE2B
	h0FbSRyOxhr/h02k5Qj7gVn+IkK57BYkYFRIsqKNjl9Z6AO5CtpqnsHpQw6Sn2Pd3JJ7phQ6lPl
	9MG8hnA==
X-Received: from plpw20.prod.google.com ([2002:a17:902:9a94:b0:2cf:1f9d:da12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e6:b0:2d9:2069:a286
 with SMTP id d9443c01a7336-2daec62416cmr113756255ad.9.1788394588841; Wed, 02
 Sep 2026 17:16:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:20 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: selftests: Fix maxnode argument to migrate_pages()
 in xapic_ipi_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivank Garg <shivankg@amd.com>

Use MAXNODE_FOR_MASK() to compute the @maxnode argument when migrating
pages in the xAPIC IPI test, as the current code incorrectly passes the
number of bytes, not the number of bits, in the mask, and also fails to
account for the kernel's off-by-one bug.  I.e. the test sets maxnode to 8,
and so the kernel only checks node IDs 0-6 even though the nodemask covers
node IDs 0-63.

Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
Signed-off-by: Shivank Garg <shivankg@amd.com>
[sean: use MAXNODE_FOR_MASK(), rewrite changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 1ddcf95d7fe4..6be11c1c725c 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -291,7 +291,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
 		 * test may break or give a false positive signal.
 		 */
-		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]),
+		pages_not_moved = migrate_pages(0, MAXNODE_FOR_MASK(nodemasks[from]),
 						&nodemasks[from],
 						&nodemasks[to]);
 		if (pages_not_moved < 0)
-- 
2.55.0.970.g62bdec98f9-goog

