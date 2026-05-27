Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3942E006;
	Wed, 27 May 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896004; cv=none; b=QYb6f7/3V4cdY5IRep4qA7diP8LzEX6dfZ1qDLcf6RvhVY5nRi+VYKHCf3SvRyvGQ61rft4qhy9WLlbL+kfWEZTcp79NvvSvZSXjk6wVCYeCVKfJaSE8UI7OgDQosfvu5Vc3FPHsrleW0w4ST8JXNS5+OHWkknPVb2Vizf7pzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896004; c=relaxed/simple;
	bh=h01IvEuQZ+K42AKMdxiewPanmZZ8zWWzxrsO2ouqJeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4E/0mk5H4vlEL3xpfDQElEItACFHBqxNpaH6UTqtLao3DmL37NJYYRp314G2ttVSJlogswAHUfhcrF0i+nAEjnTcXZVIL4x4w523LxN6R33hlrMPRN6DiqtTC9pVrfPaaf23Kt3kuTNIEGZJ5FeAwliGnu7eUY45HxgfnvJ5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLxxE+5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLxxE+5T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D664EC2BCF5;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=h01IvEuQZ+K42AKMdxiewPanmZZ8zWWzxrsO2ouqJeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NLxxE+5TXWyGmCUriYDo0nlcDjOg11eebRj5wA4VyIXO/DwcAyCiu/c6VM5TPj9Y+
	 ubHjrvSWgdj+dBSWWKty3gMmxXQALoE0Bjgs5F5tp4BiciDWuZ5EMShKg/TV3rVK3h
	 AD4XdDoaoSwzej8g3WWBKxYKVVMfdtetinaU7f2fjoYwnxiOgc74gEvV6nrt7nw1Fm
	 wL6UFXtO+1q0OwnKNf76b1WHozB6JZqrFlzibphhfc06XvZv8gaS00T/uFZNvQBs0n
	 HIJ9H2ir7VYTw2Ao7ibzAAlh+HDgEQJ3bDO8EDFwLKXJoBHVjX2HwemGr4lk0Lp+xD
	 oX9QbbpMMpfwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE42CD5BD0;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:19 -0700
Subject: [PATCH RFC 07/12] Documentation: KVM: Drop mention of kvm->lock in
 SRCU documentation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-7-4fe8b602ff47@google.com>
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
In-Reply-To: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
 vannapurve@google.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=1115;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=AfvnWtgsVpXIKXd9EvhdAVtlR2WiGKaxMZJotHAsjr8=;
 b=q6xZf/5/u1rdMaAEebXfbdUD15CwiaRJEQv8wy+OHzvYq94cMmo+p9Vjs5r6IZMkazcCQ+cOA
 vGzpCQxTs4EDZVCNaYIQXAThy7QIfLWsIT9Wzdwv9O1z6Mi7/54mSVg
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

The original comment says that synchronize_srcu(&kvm->srcu) is called
inside critical sections for kvm->lock, vcpu->mutex and
kvm->slots_lock. Drop mention of kvm->lock since this is no longer true.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/locking.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index fc4537a7659a9..437dbfa0030b9 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -35,8 +35,8 @@ The acquisition orders for mutexes are as follows:
 For SRCU:
 
 - ``synchronize_srcu(&kvm->srcu)`` is called inside critical sections
-  for kvm->lock, vcpu->mutex and kvm->slots_lock.  These locks _cannot_
-  be taken inside a kvm->srcu read-side critical section; that is, the
+  for vcpu->mutex and kvm->slots_lock.  These locks _cannot_ be taken
+  inside a kvm->srcu read-side critical section; that is, the
   following is broken::
 
       srcu_read_lock(&kvm->srcu);

-- 
2.54.0.823.g6e5bcc1fc9-goog


