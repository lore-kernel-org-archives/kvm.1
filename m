Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810D3EDE60;
	Wed,  2 Sep 2026 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385216; cv=none; b=N/XA2459IQIIgYB1MRH3azf0JPbce6rlQcA+lcg/eyZdCZUcHCo2sI+OAADeMGtJ0y+GlYrrAQK1lOjj4yvQjDLqZFAQ79Kdg5L8Ly+rgh5RA+Vyx2+3cmA7RlHxEMhf8bFVwpxXbcV1VECTnL9tVcbue3Xv+BBs4f4fOEAeE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385216; c=relaxed/simple;
	bh=kAqo+mjRUT0BlSfRzelCWYWzkrYs4gy38D74MNIKC8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxCiWMUMFpZWM3Iw/sGXykAzQfSdKbaOrXFE1aT9Z/hNOO8JBncSqK5RJ7f4EGNCpUsMFKpZzO1Cw1u3UfD+2e/S8x5YpnKodiGCJL5WaEx/yWoFhv7LlORY042TT/JYOjEHTjiZkztVx/GDUOBSUNsnlnXaGweRTFTYC0yTXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YPz0As0u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iu5tdaQi; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YPz0As0u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iu5tdaQi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B159FEC021B;
	Wed,  2 Sep 2026 17:39:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 17:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788385198;
	 x=1788471598; bh=PgMJva8TjlT6dtaS2C/H8aTD8pNix2nHXqGHdV12hKg=; b=
	YPz0As0ub4lrGy9Ia7zX80UtueE7UGyMsdgl3aqaAyWP88ylafm6H5FkvW0DVvVj
	kEqb2sqESGHgFpqmwGRnmCNEhpaqESX0+Z+7cmyJTICEuPpQb5Mhn5nRpdACBtzO
	xhsiopawqwM13k4lUqOr+aMdlBsZyoU1j4SOlQ3svyDIJUrbswgjH6C1EmNLnC8B
	mRfkbGRBuLe7nWCHIzPCCxu7p0NsCSXcQaBC5epBVVw2TOa4BHzpq8Mx6xxMOKpu
	ylE16sTOSJcD8/MOR8gUVnKduFbne7nZQfjvJKYSjI7n2Dy5V/HAj5KlLUiF2Pvs
	MibCAvT1iWpvoG4rBz4S0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788385198; x=
	1788471598; bh=PgMJva8TjlT6dtaS2C/H8aTD8pNix2nHXqGHdV12hKg=; b=i
	u5tdaQiiON3Gd++ZB5i6qigZh8jSv4dyRzxbHYQqz5L5z5l5ZxZhXFrEwSzIaARx
	r3UOVTbGfL5NBAP9IXAZpvcmFxVxknzoHqwVuMsdQxHRAqbxiB/i2oKdHi/QNn4w
	fc0w146cgiaf3jD3SmpNKiz4vv0W5v7IAqNl7ewwf/lfDErol65IwSCemv+9qt14
	9JLPVXjy+uNlEmZqF/qyh1mAr8KT32hHt6ejknLlesaA8Zj5v3h/ZS+NzBaJM9LY
	EumSJzqpCb74Gg6yE9Bd4ghjPwyMT4tZdrhN+uZoVeD7NZqwXLPpHLX5UUW7ouHn
	+tjZ/UeOoo9Qzt+Cs76yQ==
X-ME-Sender: <xms:rpeYaqXuwvraUFd0CNTst0UBaJY3drK7bF1ZXw1hA6Sy3kAkbubKdw>
    <xme:rpeYanCQJQ_QxBpA1K6ADcGPBZ5oseWqzPg5SoJ1PCffZSAmQcUp8jIjEH4JDJW_0
    Nw9ga1uiGlWhy6uLKpt24ZoiSqWtDlkzs4Ldg-zByIigvy8NfFa>
X-ME-Received: <xmr:rpeYavEbCkP8WTycBhsK8zWg9vAMB0bV5BIwNkHd9jpcdJWlxOQfZmHot80M4Q>
X-ME-Proxy-Cause: dmFkZTFGDNRDlnj7AJFko8oADD1tt7uU7qajQz6pdfrDAFyz5oUeWLgA95R+G/PPPTNvEn
    5KBIj7hammklA3weBr7T5847tE8I6akt73TULnOmhxVM2V5iPFp32dHkC1YnmYqAp+Pa/I
    PEviYq81Csbb8PMTahfroANNJO0fgEY79w0XRI2yBrycB5fa4gwE7RGAT1970ePQERxY5G
    a5ZHuh68DTh21r0Sv//Gqhm/6wb+inw1JaJK+xotSk6u4K1XCBOH8rgbw66XfuaxCvUG0w
    SQ17HVatEwPWg4fNFV9loKXEus+UFeT2kX4PSjIWdJLFSpRNZ6KEY+zlLjjlnQOoZ3K1TT
    yrgaP76qhVPHzbU7XMw3OKrkavaVIIdNJzbvLkQe5yh7NskXqoFIM6R6QIAt+JNY4su4nr
    NE2H7ld0MrtrenD76YR8zU5b5RT7bkWZxaiOZGdJ8jj1tIaDcTxt1TSBVcNVV0Scz5fo+U
    r4fMbi7F/gLbVOdjCTUYuyCY2axCtNbCKoHuwL6WsVJrOf/BoWuRC7YTWBT3UMXqHkPFRX
    or5jiacuG2flN5otLmnXMuzYIYvJ/PnnNzbR/sWIlqPVSCuYbd62y3fe4lMDrakrcNZkid
    MH9JGnlh9ujLBGnH8R66pzjqt+nG33eWAY8+2GYH4cd8Qs5O+Net74Y0wx2A
X-ME-Proxy: <xmx:rpeYao5SYNi1CI3REzAxBBMwozp3ypptvZRdqp1kZbITFh9VBRsmRg>
    <xmx:rpeYalnzvF3G2J9NRR7FPbdbMvJUUOJXrfvd6imC6eCemhf04ESPww>
    <xmx:rpeYaj6UlmAi_CqgDRHag9OO5YXcqBG0YKhP064Ta0n4qhSaySmPaA>
    <xmx:rpeYamSqkjIQ6UOe1n-Se7Cv28-MjDBf4tT4GZOkeLNQ6aRmG9SQlg>
    <xmx:rpeYauKhgbSRZxN02BvX4KB6HYJGn3_boJBcGiqkkosMwA9iqltM9pTd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 17:39:57 -0400 (EDT)
Date: Wed, 2 Sep 2026 15:39:55 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Josh Hilke
 <jrhilke@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Add documentation
Message-ID: <20260902153955.3ed31055@shazbot.org>
In-Reply-To: <20260818000550.2526247-1-dmatlack@google.com>
References: <20260818000550.2526247-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 00:05:49 +0000
David Matlack <dmatlack@google.com> wrote:
> +By exercising DMA and interrupts across real, varied endpoints, tests can
> +thoroughly stress and validate the underlying kernel paths=E2=80=94such =
as IOMMU page
> +table management, dirty page tracking, Device TLB and IOTLB invalidation=
s, and
> +interrupt delivery under authentic hardware conditions.

"...underlying kernel paths, such as..."  I haven't met a human that
actually uses em-dash and it renders poorly in ascii.  Otherwise the
doc looks great.  I also realize I posted my most recent patches with
the wrong subject prefix, I should have used "vfio: selftests:".  We
could maybe mention such a convention in this doc, but enforcement is
largely manual, and often an afterthought for me.  Thanks,

Alex
