Received: from mail187-10.suw11.mandrillapp.com (mail187-10.suw11.mandrillapp.com [198.2.187.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321826E6FA
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.187.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028916; cv=none; b=eKBF4pZPBUx/pW3PIqhSJuxLz+M4K+yKrlFq4x/gExcib4tuNJqOc1JdNUQWNMZXE3rKpaPcfnY1GsoYbEZl8XzXi9rLV1iWRSNt/gjlj2kzUw5WJRN60HKnTqFdkhnY2gj+mX3dtJWkvNMQjsurijjeJvz3/s5DQmTh6d9Nysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028916; c=relaxed/simple;
	bh=g6Bc92tmla72mW3/Z8cJYm83AgZApqnWa5dYSZrkJ9M=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=AGdi6QBsJajx3t5kDMXPiZ2CBwTo8kQH00Ho/LxyY1WW26dATp/Ovds0FlqRSEnVI7k7nwLQQvvdeZ2fWcTWS/83lKOh+/1i/2Mp/JwiPQPA/JJKDe+jqL/otFcPqghD4O7/pmg9heTRq9pAawTreeme3Hh4eKIDTtJqlqG+QxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=JLgu1w+D; dkim=pass (2048-bit key) header.d=vates.tech header.i=anthony.perard@vates.tech header.b=T0zkMnvy; arc=none smtp.client-ip=198.2.187.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="JLgu1w+D";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=anthony.perard@vates.tech header.b="T0zkMnvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1772028914; x=1772298914;
	bh=JGWN5jkvYY71URPpUEe8IqNYzfuwlhJJo5SoK8DxtuE=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=JLgu1w+DAVaGsZ0MayPsvG8Y9hZ76Px9Pc4Me0QS23ydseFSzRdYxkFUH0qPAr8+8
	 oqSfAalb6iqParUGs17bZwN7o2wH0Yyr/kLE2cAPyKxRGhxLNv22fRxT1lZaq4uoG2
	 NiOUadnshujMcjyErRI1pvzFngjCJXqO+gRTXPr2BmPQDl4Xn8Ts9Ow6W9/aCIRucc
	 L6dQ9rjtYTkMJ2AfZrfCFEqsKxzAFPU6PVWXOKKbiqtBoRT/ROWaEA3WKoiDYEjOOz
	 dSxZ6WtYmPCsuDaWzhNcJSktp+Ti19U1v78eRKvEv/UVJsbndJ3/ahTwEgG9cGhltG
	 NIuN/wdIvg+Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1772028914; x=1772289414; i=anthony.perard@vates.tech;
	bh=JGWN5jkvYY71URPpUEe8IqNYzfuwlhJJo5SoK8DxtuE=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=T0zkMnvyjPfRBymHuZFKNePMGlnWsz8EZykq82QMygktKB0ED3tXZlefTLLelbmp0
	 Dvq1ks540Xsk1I7ld9gC1mP//hDWe6gIVsQQkaBbhawejOQKE6CojpePl63AKR8s7i
	 P+spKICB+OXYsLAgbXFXU65viPGd3aSwk/ng/qMWP+QERWXBHvdIAnd3UI/S8QzpjU
	 z28J9iHMYi4oi/vhgCvBW1TmUOBT6l+kO0S26PXcjbtp0WlsZattw33VLVNffato3p
	 0TptfhaocptKS2LsTjyCC3HmfugGsZXKNAjJNvSxluhT5pZKkw2WAXXYqip52gtb7Z
	 JtcY+kj5xuPjQ==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail187-10.suw11.mandrillapp.com (Mailchimp) with ESMTP id 4fLc760ZKvz5Qld6b
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 14:15:14 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=205/5]=20accel/xen:=20Build=20without=20target-specific=20knowledge?=
Received: from [37.26.189.201] by mandrillapp.com id c46397c844e44acfb2f67c266486f1b9; Wed, 25 Feb 2026 14:15:14 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1772028911983
To: "=?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, "Stefano Stabellini" <sstabellini@kernel.org>, "Anthony PERARD" <anthony@xenproject.org>, "Paul Durrant" <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-Id: <aZ8D77iyFtqyGF18@l14>
References: <20260225051303.91614-1-philmd@linaro.org> <20260225051303.91614-6-philmd@linaro.org>
In-Reply-To: <20260225051303.91614-6-philmd@linaro.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.c46397c844e44acfb2f67c266486f1b9?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260225:md
Date: Wed, 25 Feb 2026 14:15:14 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:13:03AM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Code in accel/ aims to be target-agnostic. Enforce that
> by moving the MSHV file units to system_ss[], which is

You mean Xen    ^ here ?

> target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

In anycase, it seems to works fine for me:
Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


