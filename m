Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F33C13FF
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830469; cv=none; b=FyZXJ8wiLJ0NSKhDnm1bTUfotqL6Ld3L1z5HUYUzUg0fgblaAzzqPqMipydulv84LzC4bK2kyYtPOiMlL3wBIHmo/BKTI4uS5NSlstj2geqyrkSwvV/wQSWtPwq6B/zjM6y9yeQAyxlm+9CFh9Yk4rUCmwQL/fOTMlBsAaNbLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830469; c=relaxed/simple;
	bh=g9UcIvZLtTAiwuSyN2Re5gnR+vYN9iOFUxwQ93PpFSI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dJwy2Jz0Fw6z8zxv994kZxjW0ftcVz18juRRlqp+sQrXyqDQ6E+gMqlz83etEb/qi2S0TjFc6PXiRKViNPOzwTJO9g0ZMW6ydftqZUBE2D0ZrM+6G6sC5vscf+HOViYw3sqdg5E3/ere6t48e1cysIx3Midx7SEK5F0WdP+iWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mTarKUwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByiPwWG3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mTarKUwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByiPwWG3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A522140011B;
	Tue, 26 May 2026 17:21:07 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 17:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779830467;
	 x=1779916867; bh=ihReAPYRYuC+iqRsbFHbzekLUVkxvZAJWRMSdSVrmN4=; b=
	mTarKUwDux3WkqyVscDsMQf7T3N6aQeIcHD7aLuZaP9vw9tsetsFYgzCuFt2Dd8v
	mLLPFzVhn1KDrUct2+RKV8cCga523jC6A3njS5K3c6JQ2DA/IZ3Lmhrw6OOKVENJ
	wdWYvbvHESwbBKRtWIJk6ozDgZ6rKtauoKPunqRgJIrVfcrbx+xZ8o5yVLt9Gkl1
	pf+0Cs2Ilx/tkfVYRKWXYVwDf0/ZQIbh+lwML9q2UMRuLOqim42CzCRbRYSDRDsO
	/TLrflEHj8FT+Ye2GAWDqF7WiXU5UEjBAQVPSR5hsQvkY+Z8TjTRdGRr6SYem28v
	OAb+SbHDpicOGNp2YlBy2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779830467; x=
	1779916867; bh=ihReAPYRYuC+iqRsbFHbzekLUVkxvZAJWRMSdSVrmN4=; b=B
	yiPwWG3heeoYi5F/srv5Y5WC7GOoYna9oWu71iVZRwCF2bCgUcqy8lDe/O3920A5
	pQBTXeVdt6keeo32JsMBgSqr4Uvj2RdlFovAw5obOzoByUzDLrbi8Xm9NIEKJJ38
	T8kxEoVn7k65yDdez0bwcfuoHk7P6ACh2RGFXYRFIuYs0qyulNGcv7FpaNeX93hV
	L2Gl2s0oxjNBPWq/FR5cMnWEwfh0iXvyse9z1f0Kfrcpq7QqXKBgMhi6rNRTXia+
	IEx+p81BschdPs7BmI3rw68oy00EqyuqxkRHtNmMYI26rjT31RP8H7M1ztMkx3aG
	eJq2BbpfYzeqasm8Tk2qA==
X-ME-Sender: <xms:ww4WaqGiaZ9YyRFRE9w77-XrwlF14x2L_PHNSsjjhGcrhuNnZCRSuA>
    <xme:ww4WamK4ES4OcmPTtYovmX9cTEWZ-tPGCJSDh4jNHgmjYs7W3LuJfdjdgXZNH4Vj3
    iHXeJktoXdS3SPWCgVJiO_KZYYXIndS0Ra-K7JsDNmqckwRzdPksr8>
X-ME-Proxy-Cause: dmFkZTEk8AVuVH6VkzZaMqYl3l1QwAg8hV2a7mqfAtIQk5efd+r3HW5tvX2qeG/qsW5cyq
    xSUFbBcKwEgnJ4KzictU2kDz4W6b02hzv+OFuQx2jGlxweuctIudXqEpjtlpla9pm9UL3R
    FAD/ty2J+C98aDh0aO1qfV+yphLzr+nH5XfTOqy0+UXSLi4n89U0YDWR9QNX96kPomjGQa
    aodZWfn1ug37a1HuLVoidc/Oc7YV3yAcgP6ESMK+7dQqvePZgN5GYVGlU233UhhEh4mzq1
    USrkEXfSRSeFQPG2hU2rIE5ejazX/mbW5LSlR4wRrHzB0woINsgql4sjkBsla7gxs4wqKy
    tiBYecziooHdQda0CdJzQfP5tz9eewwSX+VLjDZSHUOWUssUELE3yxEmutDPwB1O3as+y0
    2eUMclZ3x7l3pbgmqz7/ZMjBmQp3BGCFrbEbwmhM18P3IKmLU7k/0VPVu7d6dm9yz33G+z
    Mc2hJybBJIXbRFAKQtU9laAXxJaeMQ9SzCNohQyzMHLpgWW/eUE9Q+3QEdeBidG2ty4CAt
    0LfilKTOkHzUks2vRfnzUNFKUg0dJxgokgrxcY2eZHbNwHC2FEVmWd5OVzebbNilZXZnMT
    FIDB22eJs4NjXoG0PItipYgy7dt/tSl0yl/S1rsUYm/ApvE3MQ6vIwSYDBSw
X-ME-Proxy: <xmx:ww4WauyE561IlvvYKxBbD4TQqh9U8dsSaJNCVO7cWp_YPuCgWn57Bg>
    <xmx:ww4WaogmCKGn0XE_fjn4lxN9Gfrf4OMw7qPDT06gwGdWOOdT5ObqYQ>
    <xmx:ww4WaprbxE9IAArQa71dLUfsYBsnJBUhllVazj-vnl4G5_3uOw9YHg>
    <xmx:ww4Waniv-shk3peRgWI4apUG1o61rfl0WRc7nUSR2z8APB6XcRa67Q>
    <xmx:ww4WahGIHnZz0zTA1DTITyGHG2EWGXQvkHtGJEXkhLwEZOD8jAyDj95Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F1D9182007A; Tue, 26 May 2026 17:21:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AErMMLfrjY2s
Date: Tue, 26 May 2026 23:20:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steffen Eiden" <seiden@linux.ibm.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Andreas Grapentin" <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 "Janosch Frank" <frankja@linux.ibm.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>, kvm@vger.kernel.org
Message-Id: <95926749-df35-4446-94c2-98d6b13007fb@app.fastmail.com>
In-Reply-To: <20260526170835.185462-B-seiden@linux.ibm.com>
References: <20260526125220.1560451-1-arnd@kernel.org>
 <20260526125220.1560451-2-arnd@kernel.org>
 <20260526170835.185462-B-seiden@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: kvm: arm64: add HAS_IOMEM dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 26, 2026, at 19:08, Steffen Eiden wrote:
>
> I would squash this in v3 into the patch that creates this config:
> KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
>
> if that is OK for you.

Yes, please do.

     Arnd
