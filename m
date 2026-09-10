Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A93A0B13
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058088; cv=none; b=OBTRRzRED/dGjR09FIZxZYdt6TOPt3e6pbPk8aLZsmoRJWpU2VG9IneGzAiVPGPJSNXSAdOEhLrsHfsGNlll6OdIjtoDziQwj9bM4qNf971PEhxO+nBJhO2LZluwOQR+UHIaExZ4DJZNn1DTxzOD3beOa30R+HKK7LHGHRImDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058088; c=relaxed/simple;
	bh=1jRHSjVONBlrUzvm8ABGO3sExe/56aFldq5+yO/Gl3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mnSrBhGwEZp8J63XMGFqFLwLT8vBktTJNYHTehpyYcPZa7m0NemZz92ZrBMINqcJFfMo7qE+ZNrYhzilmwKbWJtZc4U4/lBAHHlscV3VoSMgghwVjnJWpfYceTAkUCWQys+gxQ0CSHKqutdpIKVEHSTpPmaeJ1E1mytjXc/xqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHSdpMIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHSdpMIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647251F000FF;
	Thu, 10 Sep 2026 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058086;
	bh=FFmXgZo40C0UEkrxpCYGdZsKmnykRFffkwH//VOkX94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHSdpMIMMgVQoiwDTL86SsUoqDvfFCVOMR6NqfRU99WKZcsLFkWzx9krxkQh2nTpg
	 aOEwD9xCGUcxwsrsMBmJ3BQLvfduVYoCuedLVAsUbeEX5Ozjd6qL61Hh849Q8zFsI2
	 WqDitdCO/NKWBLIbPXaScddy2r1CsqzcePcVtdeI4ZrgBerHKNeXN0dXs+saGQp1oo
	 +Jq/vylbteL2RbUBJDWgy9IK5ARrd+pA9FRvFYkKbIziBDlLTJgNnZ0VEDUM4X5gw/
	 RB165U/A+YGnQjmL3Tvcuiz1QZcuehH8Fl0leXiOV6reRWLI5Q0XkdHX8SXEOVfAXD
	 V33v6pJiG8qqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/10] KVM: Add basic lock context annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Elver" <elver@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910162343.4092060-7-elver@google.com>
References: <20260910162343.4092060-1-elver@google.com>
 <20260910162343.4092060-7-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:34:45 +0000
Message-Id: <20260910163446.647251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Using `container_of` inside a lock annotation attribute causes capa=
bility expression parsing errors and function pointer context mismatch.
--

commit 5dd3470925b8b06c17b9c9055b2f5ae6c47704d3
Author: Marco Elver <elver@google.com>

KVM: Add basic lock context annotations

This commit adds basic static lock context annotations across common KVM
sources. It deliberately omits dynamic multi-lock acquisition paths.

> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
[ ... ]
> @@ -300,6 +301,7 @@ struct kvm_irqfd_pt {
> =20
>  static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
>  			       poll_table *pt)
> +	__must_hold_shared(&container_of(pt, struct kvm_irqfd_pt, pt)->kvm->irq=
_srcu)
>  {

[Severity: Low]
Does using container_of() inside a lock annotation attribute cause capabili=
ty=20
expression parsing errors?

When context analysis is enabled (for instance, building with
CONFIG_WARN_CONTEXT_ANALYSIS), using statement expressions like container_o=
f()
inside lock attributes can lead to Clang Thread Safety Analysis dropping the
attribute or reporting a function pointer type mismatch.=20

Could this be annotated differently, or perhaps the lock status assumed
inside the function body instead, to avoid using the macro inside the
attribute?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162343.4092=
060-1-elver@google.com?part=3D6
