Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456967;
	b=0tYMomdlSVu+tStop2d3jivex5w61gH80mkciwlhjgolAx5sAxVxz4AFbs6KOBAusx0f
	 dSVwWdnXSBC2rHhqLTdiKVzT+Su5tLYllLNhlViVUrFEWhNK+OMNTELp+9215kCQHh88o
	 Y1txEvRrIdVC8dItU3dKah7zJjsU91oZgTvN+neKSz9y/g+K1eQoghgAWuJBJDaHnkBw2
	 00TukvdPwaF3Zi04KIFUz8Xdc/8CCxtCafeZZwqfNy/fOc9IDLGknPK9HN4O1zoWOFVCm
	 N7MReuTZvvEH/99g4d6pPKfLDUYIbL0QIY9wfx99yUkpr32CLKvOP5vTc/ACirCwc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3J70vx+UFwT/CKgCREVaEnKIq2mzPLeIJwVvWoQTl90=;
	b=aCdJVFZIWh7RxDe+YsZJWNSf+ZUEanZatT8pjGIUA78ar6pp0vxDq2671RXbFFRIrs93
	 NZDM5wp6DLpY7Mr1AhCoxj9kWkxRBJ7+Ai/4foY3JfO5c7pyiMmpkmkCHtgTLcOl/CLEB
	 RftPeq7Dnuc4UCZ8QoWy0oWwTtklgj3ONdTTBZCTQHI3e07LZy4Eg4GWF/Kc9YJaX3zrk
	 8xex2tJJTymtx4Seov0yNTZpYnbiwwtvn8+qJx5LPssBhcFjZPPr/Oy2dJP59j5vGVuld
	 Q6lWKNvWDTgF+ZT1qoWTbPnAgj7z+zCdD+5TWhyqb2no44t8M8pww7jLi2rTak9fNCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxPUaLJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F760606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxPUaLJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B95F1F000CF;
	Mon, 23 Nov 2026 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456966;
	bh=3J70vx+UFwT/CKgCREVaEnKIq2mzPLeIJwVvWoQTl90=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NxPUaLJklO5O4L3xQZin+kdBSFXEAmWf/2h1AoDXyrvc+LMT2RqOegFy4s9jG8qy0
	 Golv00FWt6mbC2AfVcPn6J3wDiHzijermXera8+Z+glL0FTY6Nqx3JmqDNjknIxYks
	 yhgGRbPnDjnxYZ+U4KUp5nHyZpn567NP/6C1kgRhCTnR8JUWqiWIuD4m97XqfFT7Y1
	 edzyseJ+r7kieWPWCBNzmeEs8yif60ST3Wt6TpFW/SFIMASs4ZfOJVQC3NsEpl4skB
	 eYMB/xjBDBFuBKuCe0clpcTpR2d+IPZfBEkHw1RULRwT5/klLs2yuwpVigz/cV1OwI
	 nLkOT3usJ/eMg==
Message-ID: <sashiko-outbox-229790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] KVM: nVMX: don't check PIR.ON when processing
 nested posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261123175512.80438-2-mlevitsk@redhat.com>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
 <20261123175512.80438-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:02:46 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: nVMX: missing Fixes: trailers for nested posted-interrupt
  PID.ON checks
--

commit b99242cc2d5d177888bd387559bf392b46fc1d67
Author: Maxim Levitsky <mlevitsk@redhat.com>

> KVM: nVMX: don't check PIR.ON when processing nested posted interrupts
>
> Despite the suggestion to test and set the PIR.ON and avoid sending
> a posted interrupt if it is already set, there is no requirement
> for this bit to be set for posted interrupt processing to happen
> when the target CPU receives the posted notification vector.
>
> See section 30.6 POSTED-INTERRUPT PROCESSING:
>
>    "The processor clears the outstanding-notification bit in
>     the posted-interrupt descriptor. This is done atomically so as to lea=
ve
>     the remainder of the descriptor unmodified
>     (e.g., with a locked AND operation)."
>
> Apparently Windows' implementation of APICv does exactly this:
> it sets bits in PIR, without bothering to also set the PIR.ON.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

[Severity: Low]
This fixes nested posted-interrupt processing and wakeup checks when L1
triggers the notification vector without setting PID.ON.  Should this
include:

  Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processin=
g")
  Fixes: 27c4fa42b11a ("KVM: nVMX: Check for pending posted interrupts when=
 looking for nested events")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123175512.8043=
8-1-mlevitsk@redhat.com?part=3D1
