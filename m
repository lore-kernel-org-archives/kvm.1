Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADE4E2F20
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954428; cv=none; b=sg+4Vq+4GDMNHhfuUEVdrJgottJ2xOBL88V7eHWu+r//aKAhv/4TYIivNlecstmUDhBNWWL00rBCH7l/QseBXIpeHMnuiDoeVlJYbYD5IoZjn4iJ6pA3VWCSxZdX0cDTzUIVz0X1zNxhHZlP1+874xDVKkOrvP3Df1p4+6ehCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954428; c=relaxed/simple;
	bh=jiRlnQPL/4jn0XA+0EpA4cRvVnRyf76p+dgNnwem+7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpVjcWDoaiGZJZFLnyS/NKlqNFa25W6coGz9fF4WXbd4d5JLoaja3dAJX8up1Z4gJ6iLo6LsIH35wXyn5hz9G5aHuXRiBByxEi93EngLVesqHmeT8b3rPNzTLTCWzGmmI+Jkf5GLm2674qVA4Z8iJjogp+7KOfHXX6JgFYWRyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=J++kYhkW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="J++kYhkW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso103035e9.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790954420; x=1791559220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DX8YXk9lb+w/GLA7rHIr8s7xKmdQI537LSAHJBywLx0=;
        b=J++kYhkWj9+SLNiKsoL+D8NzoWCWJcK8iCe5h799Zsazgagvd1VJh30KOQZjZMfH32
         Xhk15Xt8gNOgkfy3rGrDU4SmjikuAZ+qNtzNxCEO1KEIxZ2DzQdrqBAi1lKCca8DkU6R
         +bWyFAyajVR96Qe7LGpDi/QvLXXxSLHJh/J9896HEWT1IM8DjZI1Oo+5k7T7kg0lkryJ
         NtHUCoI91i51ZzH8Q9rD4QgEQ+QUzK0kBVJ49Tavqz8W+Zoh41HPEFPYEohz+pAa6xO/
         rYbf8Lso19sW1JmbubLRIkotwCRAO6gGfzIEy/BmkK5oy/XZD3n1wPNky2stBSVXluw/
         CG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954420; x=1791559220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DX8YXk9lb+w/GLA7rHIr8s7xKmdQI537LSAHJBywLx0=;
        b=CSDnHbsMCB/J0VB98QuF/TNZ5bxinrNvDzgrbw3SGgrUBytqfAcCsz1hm1L76BciTN
         gyX5tII5bzVwHlQZ+9wfdnUwOhTwuqF96uqgKC7OM7nY/DJ2faH3kdW4jZSXzmPojeVI
         JCIQBqgbg0gQpAt+tUTVZ6lEkXytyB6knLuSm92JtvPdZfmcBsWOAXjqgrq4Hk3Z50PE
         iOcnLVVjibmqIfw+qDl7G0igq0wRdiotvShppM6F2Q94405EnvzS/SMOGPrNdWg5AP6C
         kaml2UE1Jg9IGrWpaOZSJRSDH/qc+HMdpSbSEhW/EEUKlIu3WQYUtBbsdH1TT8SHyE/e
         sYOw==
X-Gm-Message-State: AFuF++llR+hwVmQo/yAcw+/Doao9GcjAAfcwFPBh19gGKzPwV7Au/Dug
	yx527uqG3G1o8qYc4u1hda/gvZfL5MnPvymbq1KDF3hxEUqccDWZLgTY85+7lCGx3bk=
X-Gm-Gg: AYBFou24u7sW9A0cBroDIgrZQzwmSQL6Vol9OsYABgvQbQW2U/o+Blk1tY6VdJRICOA
	rBA+MaIGNwETMSchXN+EnZszAD7m9ARLIb8qNSKRRHVkf/S+808yAQ03mBk0VF4svHq01SRUNjK
	jji93slO6Y29qc9KzsXtPWhyuk921BjhsLWxCbtoNZDYMz+HxaCRnSjudl+KJJO615KwLsUKBNT
	Fy4WIwqITqSQgVYEXHohW7XvUN1MCprkQ9e1bmwJTOGlOiOMzjXPtfhwq+HfMvoM1v4TRh+xdTZ
	VmdacjYh6gyGM5QxSZvFQG3fR7eBEUmAZMr0V+6vHy+nMsfEQNB5PLFX/NHh+u4yepcWVV4ru9y
	aHo8WPQ5B/1K7Cd95LGnE4K51qY7Em1eKOiWYduPxz8BjHjB6751FydAFCxsc8a2QtMaBG+fkse
	LoOGjIR3J6Vswr3lB9iv43Z4pZHFX+i106+er4P+uFzNGyXkCs9Iz3+Ux5tgyReMfG3mzMXflFe
	WLzqJ/Z
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a02757999cmr55471925e9.16.1790954420036;
        Fri, 02 Oct 2026 08:20:20 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:9c5b:8aff:fed1:19b4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03048abc9sm32039625e9.0.2026.10.02.08.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 08:20:19 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: kvm@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] KVM: x86: Cancel PIT timer on failed creation
Date: Fri,  2 Oct 2026 17:19:42 +0200
Message-ID: <20261002151942.491680-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

Cancel the PIT hrtimer if PIT creation fails after registering the PIO
device. This matches normal teardown and ensures the timer no longer
uses the PIT before its memory is freed.

KVM registers the PIT's PIO device before registering the optional dummy
speaker device.  If speaker registration fails, a vCPU can have already
programmed channel 0 and armed pit_state.timer through the published PIT
device. When I/O bus registration became fallible, its cleanup did not
cancel the timer before freeing the PIT.

Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 arch/x86/kvm/i8254.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077..b7875345f 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);
+	hrtimer_cancel(&pit->pit_state.timer);
 	kthread_destroy_worker(pit->worker);
 fail_kthread:
 	kfree(pit);
-- 
2.53.0
