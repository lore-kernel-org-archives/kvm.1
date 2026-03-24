Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278A3E0C45
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365725; cv=none; b=NXRO0XNPMShTOsuFMxphinNRM3BLqWz7Nl9m36HekguhixF8prQhIkdXsQGay1iI1gkkcUjrf4gQmnlMqA28p0ukLUpvbQqcAKsNXS/O8D/+YoXoDlzbvFE96yBGCAn2rGDVGR/qtjLSn0cIYXdRQsrGRoZLZdw9mGMuafIJZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365725; c=relaxed/simple;
	bh=kl8CtbvWh07s3HuWlRuuMORMFo8Hg9fw7Db7pLB0m10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fj73QK1vl+9mc+gStimZcx/JfcOphubkSfpgcnguBnOMHA3lYrV6u3GIUnwK81lhUyt/L+qW/iDPlIgGmgGbLGdJabYJ1+xNo32DAD+OyqnXCmiABAtdSH1rjIaVqXGd8+JVVIDacsgjLxesmqo4L8S/p1YwVocXHGML6D654F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVQ38atq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVQ38atq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KyXoMxPLMzIjjaRu95KWvtWstQU6b4xGXqr1BK5wONc=;
	b=jVQ38atq12lKeVX/kA/mDaTmGJ9AfMQ0jmQtP1dzjO8JR/5VwjzlQ74UOfOlNBuKAB6RYV
	zoTl2qye+Civpm4Wun7584a4P6GOj9xDf3LvHD6ds2AzD9LSBXCkYiYFCiQHa9JMvsJhP6
	mu95148Sc2+UJbaTSMcfNN8GUc0v1DQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-NDDkbgv7NRmHTbj2s8qVUg-1; Tue,
 24 Mar 2026 11:22:00 -0400
X-MC-Unique: NDDkbgv7NRmHTbj2s8qVUg-1
X-Mimecast-MFC-AGG-ID: NDDkbgv7NRmHTbj2s8qVUg_1774365718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F0D7195608D;
	Tue, 24 Mar 2026 15:21:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C6CB180058B;
	Tue, 24 Mar 2026 15:21:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] x86/tdx: Fix memory hotplug in TDX guests
Date: Tue, 24 Mar 2026 19:21:46 +0400
Message-Id: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqAIBBA0avErBswE6GuEi2imXQgLLQiEO+et
 Hx8fobEUTjB2GSI/EiSI1R0bQOrX4JjFKoGrbRVvTZ40Yv+uM79drjJywmtMaTUQAvZHup3Rv5
 D3aa5lA8jqjNRYwAAAA==
X-Change-ID: 20260324-tdx-hotplug-fixes-644d009dad63
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kl8CtbvWh07s3HuWlRuuMORMFo8Hg9fw7Db7pLB0m10=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpwqwR1s6ob2QVocgSTxamDC3kgJuIWjyet8JcA
 jUL9/wWIlmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacKsEQAKCRDa6OEJdZac
 5fQwD/9/jYD2cjfNUCLCtKUHJPxSAfZNLCJ19Di8SzGCwNQ0itWINJv+kIjzCNhHoD6T+lh3AsI
 LOXkZpH/4IKpa5QQAQTrPpKphHpVIHkhmxk1K0pD4c/AaJehzZ5tR6PCV3QY68qWMK/bSc8HeCD
 z7oMP6W3z8E7Pj9DLWctqgPISltKWPXdFBBcI3qjOYR7/D0lqWMb00fkw358lIfor3n6acNk4mi
 ovWzKUUoa0JiuS5VRU00gWOmDxN8gkz6m9G+rKchoRjWiECMzaMQ0LKlz1Jum4sK0xXek7s0Sqr
 1aFAwczCV1AEuZrBLaHcvwPd07dEg+vonyO2qEhje54QhtP2KbRE2YivV6RsxENHT8B9zC3umLI
 T5Sm2bIfxgXG/C6fql205c2uYbVSmdKMmp5jCKkw15w/ZqSkV3kygtx9D+ez2X2QfEPnTp2c9mS
 O3C3Lu8UvkL/+v5qkVK1u8TB5REERCvt+GriOrdKLfpoergsoM/bvNp80sjX/WySVC/EyB2WoC+
 kfZbPAwKTON+N/xZNp7G37eWMMEIH6hE0m0GJmfMrpU+ZBIZkMHwNXL6yeaMcWf/TdSMK6QV8zS
 Zqw7GeudDpeakq+ov3uVZiySR+LAhxQv63gNDXOeYJ8/7FabVOuzcwNVAmMxKRyfQOpHTdodGBD
 geIg4Oj0UNgh9Zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In TDX guests, hotplugged memory (e.g., via virtio-mem) must be accepted
via TDG.MEM.PAGE.ACCEPT before use. The first access to an unaccepted
page triggers a fatal "SEPT entry in PENDING state" EPT violation and
KVM terminates the guest.

This was discovered while testing virtio-mem resize with TDX guests.
The associated QEMU virtio-mem + TDX patch series is under review at:
https://patchew.org/QEMU/20260226140001.3622334-1-marcandre.lureau@redhat.com/

The fix has two parts:

1. Handle TDG.MEM.PAGE.ACCEPT "success-with-warning" returns for pages
   that are already in MAPPED state (e.g., after offline/re-online
   cycles), instead of treating them as fatal errors.

2. Register a MEM_GOING_ONLINE memory hotplug notifier that calls
   tdx_accept_memory() before pages are freed to the buddy allocator.
   The TDCALL transparently triggers KVM-side page augmentation (AUG)
   followed by acceptance, avoiding the fatal EPT violation path.

The solution was suggested by Claude Code (Anthropic) and has been
tested with virtio-mem hot-add on a TDX guest. I did my best to review
the produced code and comments. Apologies if the agent did hallucinate.
Let me know if I need to check or correct something.

Thanks,

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (2):
      x86/tdx: Handle TDG.MEM.PAGE.ACCEPT success-with-warning returns
      x86/tdx: Accept hotplugged memory before online

 arch/x86/coco/tdx/tdx-shared.c |  2 +-
 arch/x86/coco/tdx/tdx.c        | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-tdx-hotplug-fixes-644d009dad63

Best regards,
-- 
Marc-André Lureau <marcandre.lureau@redhat.com>

