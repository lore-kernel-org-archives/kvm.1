Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925056;
	b=rzfbn3fOqTRl1USd0Wk9lDcfnvHQHbO8uW5nayLnlcR9y3Ha22uLvCQVLhAJv7X6ozhQ
	 APRxgQdeRyT4DsEc9Q0dnIbIPEP30A8RD3KATODUJDJiNWeIE2uEzN701kj5Mw0PMviT4
	 Cg1nJFy+kRN4PihKkWw9xd30iSKuWBKuzC32h1gnA7VxA0S+vqbAO4UV4TU1A+mIWqRxn
	 YKOoVXmeiVRIwRJ9YLp2EzIIzayt3GbmFTeGvNCtfffKBIv5w/UdJ/uq42L0ezi1e871J
	 MB++FsvopXyzeI5O+jKzyQssi5faS9KXka8GKERC8GphhDHrTXLmXFzXAwDs87oZatw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=BLybj40HRrk+JRnjEtELwllmhvie6n0a34/NGObtXmQ=;
	b=OrFEoCSHQFtnb++7X7CAhC+mTjv14jY7DxMiwzmyi4L8WnmMWDJEntrPfvMevxOjT/Wx
	 x0lHupdhPC6eoKvGMTMDyaNxKMK5OW/cAHvTgOqc7t9mcMO1Ox8B78djwWkhrAtq8JoO/
	 cO+VBwCgO0HVCBwZMnx369P9jV0ZHsxLnGiXNNDVgYvZalSahnZJa5lx9BsQHx/MIEnQ+
	 xuVuPRz7+BDDjbesHmO9ppoBhMkmbxG1XjezFZDXlIDkXutNj+tmoXdJxxwiEMSsSVCQs
	 9c9gkndRHMdizNCB7iGxD1czvxEdi/wr8rwNwi6bBb1/IyJTQSlsqofL7PSTOmDDi7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="TSIWC/QV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467A606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7467A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TSIWC/QV
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so9519e87.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925055; cv=none;
        d=google.com; s=arc-20260327;
        b=g4WHGUkqEzNxgMU88IW7CqREKjZdEqOvLRCcDXbr73NM+xd7yc2byZObM84Q2mPr1j
         I6ED2NLKE3of4CfwDElhYCxOocQhYyCtNiI2zOyCTJw9jWlCRnUVTyVi3bwoH7whJBAX
         r2uqRmfi2oxibdET4+dkU8Yj2oE1r9Rp2DP8bScHdTZDBcYAy4DJiiWwr5eN6XmoDJcE
         SHWSbJmtHpUXcC5l19H4BLgKg9PNASjD4/Ikp1r22uS0mMMjzpTAwAbQK8zRUlK3RrdR
         blIyJrY6PLVjBmE7fIGz84glNkavoxvQyCoGFrKQ4HFcl8ZGjoxNtNJl2gUNsWsQovqp
         ytKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BLybj40HRrk+JRnjEtELwllmhvie6n0a34/NGObtXmQ=;
        fh=ShOtn3DH2JacjDhhRuDN/ZzoL2uaqKg1U53ZjQaTW3g=;
        b=lr0sA+aCR2xk5vXlnkFBc47YQR0m4EGIIXmzPhayfSGIEwq4HBcsS6wd5597+KP9do
         atpNrFR6hOeQOQrn0HKKrS8btoa9F7mJIMtyTLP4IOSb6AZz3tzgNGj165n4NZqMon5s
         nnum7ehsaUWhUCpZBNpxdUPt77F8AyHdNoPWCmdqAFyw5FYmImkZgQh7u989R6N2/lf0
         0Qe+59eLNtwJ/lKagwG/QAcXeWyiWosrsZOdizx5fH65g07Gj6gyPtflweeeTZywSN1K
         DVVvt3glV5pV4VW/1mmfD/Wd/ZMbRjZVRbsar40k3HISMnK5YnD2msiR138Map4kEkeH
         tHhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925055; x=1795529855; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLybj40HRrk+JRnjEtELwllmhvie6n0a34/NGObtXmQ=;
        b=TSIWC/QVyYBfzqsmHL9nh3w8LaeSUq3+mwAdULlmG/xH2uD0IE4cQCxFq3Xtjld+2p
         HGm/3meGmMM4ORkYb6nfk0xkfk57pHfPUbCJICja4Upj/jJ64NiN8T/Ry+g68591PkHC
         jiHIVYhb+padhOeDynsOzpZtdHvlLJLzSoF7wNWjBITE0QcL8bVBEnaIUxUGwCAwwSNg
         FEcXYneyy8DishHabreZxua+Z80FZGj88PVMGd7Ez4zA7KdVtaivoDIW7bem0Kmuc9Bf
         x/Lmp6pIlC/nbPMbqt8pVFm83TMx4zZKXsX7pA0e3lWGH5jZcGLAKk5wheKnBpOZoBRB
         WfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925055; x=1795529855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLybj40HRrk+JRnjEtELwllmhvie6n0a34/NGObtXmQ=;
        b=uAU4OMe90F4R2A4YB189fFHASNspP1QGZBBWbf41LOHF2T0nPfN62I27ybuEDFM6Q8
         5wm25g6Dr/Q1MSndznzJGyCreOBwDXW2aVYaQ9MTVE5YcKSRzgAYlh+c2wb94ZzRjZ9b
         F/HSFC8zxsSbHE3Z5SOnRrUVJnmzjhgsniXchjJuve4LQEzusVsZezprdR0FWBKZrEMy
         CO36bXW4tpQVpRdmi+2f8x2EhngtrtbXsSL1EB6dlXCuuCkl4dZjnr9busm58uYr7i60
         4+LQ8vi+aRTsmtHJ61FqLjc6SYdMu32DCO5XLfEOHs7xGKoJohwFNrI6eK8Sa4cy4f1a
         AEFw==
X-Gm-Message-State: APuU4Z/E5g3Y8GgJ8Ph0jKLN5j++O5HwxPK5htg5+tI5GHsOUQ1uxV6/
	kRxlOrU7wvoaoPfT2GMAXsPOAe1fmrAhhRM0l7QZ65WIIfieydja51nuluNsjrj1fWfp3r6NYL6
	LwwlwJZM19Us5EmQsxixnHYGnQKiVBYMDDhQMN5CB
X-Gm-Gg: AYBFou10HX7rnEyl46r1JJnvyDYtW99EkriEh//SbljVUGB2ytYaKVOFNX03rZeKUiB
	+uajQ7nHWkazg/7IUqHooj7IoRXdwM93qkc/drO5LOoqKAlMw+PabimxgCWD+MkSdaE8bvFzFum
	o1MZ1Hwl8IreIH4yewVd4SieddeIhnpMZpBggvQPF1cG9X0/xW3phcxl30+925LWsXJM1OR0GBz
	xDjBhnZl9gLWtEx8ZOgwh83NmJbzt6MiWcmngvtBJtH5QfiBtrL+Y/oaIDoTgjUOBCY36/stwk7
	2H9fPHbPCscy7FYQK4ixGgyatigy3wtOZar8G+yjs9VA/z4kmXF3pdB3nWWDgoMR+h5j997o28Q
	MhNZPVQV2QxdeFJAf0AmkKodXnwZgWDrTEsxz13Cho5OYQbT4FcqvT0BVxv8xOD+wUmaqs7wDxm
	Zux0OZfk4x55VeRXe7xyiEIOo=
X-Received: by 2002:a05:6512:1320:b0:5bf:f060:c0f3 with SMTP id
 2adb3069b0e04-5c1a218237bmr141450e87.12.1794925053973; Tue, 17 Nov 2026
 06:17:33 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-4-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-4-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 14:16:57 +0000
X-Gm-Features: AclHuK961RRQGs05YcwTvTpXpMcWfGbS65nrobWrGykL5gw3Ev5XjAPi08pa1t0
Message-ID: <CA+EHjTyeE0gbLgfiDePPVRR88GFVa7G-G8sr8k6vzM7v_uHxdA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] KVM: arm64: Handle attributes in stage2_unmap_range
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 16:43:49 +0000, Steven Price <steven.price@arm.com> wrote:
[...]
> With the introduction of private memory support, we need to
> handle invalidation requests with filters for a given type.
> Add support for passing the attributes down.

nit: what this passes down is a filter rather than attributes, in both
the subject and the message.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
