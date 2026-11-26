Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683799;
	b=AIYSiU/2x8jKQaglWoGna4tDYOAMObt9piBTSNAEI5mwvAE5h9NElqbcYkzf660X3AVh
	 TDCglvmQdnmfu5oA+jSkq1Xac600RR5aEdtDQZPTBy5KLGrj61vErIMkSNaX8ktmT6G8r
	 lIv+i/vdOmnMZ2p9RiTF0bF8FWA58ADbylNXIYxenUlPXcXpR8au8bjvU8kYVaGszEpBy
	 9Ncr7Dm3UQ5EUr9hKcoiz5fRQX6OXvYfXKwRFW7sQO2OzXVPqdqs4MkdjlcGyEEsDtI9c
	 KKlF/+hWzzQLyPNpBMq4SJg95Rn9o6r7k9akSS5YurqgfbFjUXuBbd6/Joh1VPwd8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683799;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XBH6J36zAqMuTH6gInfNyyU3T0R72ozkDXLkDYbWtFw=;
	b=B4f2CeHysmgKKNhl3BpNOt4B/lBJb4fqy6xscDNvPGFP7a0xHiK8dMm65MrRv/zzv1yd
	 TuVE7HtA674L+zmHJNbAxAWgNZ93ni+lSCKZGJpIWWYiiCHl7rdyYNdz8Z83mEhiyhlHB
	 3SpKdcvqahG6IYIr11jfehOkGQN+7pHv4a9y4H2DPBfKZzVXSrKbJcipPBlol4KnTTJHA
	 VGphKxGlOGqalCb6dDIxc1vhLO4NHsfcJabsVaPOwqx28jZ23prnPEqbZ9ivIxBQ6Md0Z
	 cWk6woj0Ia0AEwVt+cqXa++0tshlsG6LQwQkONytJQcROlz/0cfSlzRa0NcfOSQB6Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHuBdpj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96243606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHuBdpj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275861F000C0;
	Thu, 26 Nov 2026 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683799;
	bh=XBH6J36zAqMuTH6gInfNyyU3T0R72ozkDXLkDYbWtFw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AHuBdpj+ksvDOq/+TYCeRg1tGS1H5CDXuIaaLkmNfH3SU21wojS5JFDlCZGPcpGg/
	 YQLw+gNuxvlQFQRt7b2ftT3D5/DuIhJl8Q2B8yMprA7TE9Ecix93MCWZZh4obCRi6h
	 0QUuyrXopz/BOk32m/lvs0c6mlJttvU/1OQFGaTOBKGP2asuemPuCLeXBlUCl5VVIK
	 d8EkOEfmKaqto1BwkhDVU40VvHNByi9n+lGeFswuXX8JfecYlRLztcHBqWZwSiPcLv
	 oyL2tH/KLTxtoxbyUiWFme11enwSAEu0wpBcWl6fkwV2/Uh/7ikVdJ6wPQ18umhghx
	 JTh72W7HdJjJg==
Message-ID: <sashiko-outbox-235073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S: Synchronize TCE hcalls with
 IOMMU table detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261126085008.34532-5-nnmlinux@linux.ibm.com>
References: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
 <20261126085008.34532-4-nnmlinux@linux.ibm.com>
 <20261126085008.34532-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:03:18 +0000
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
- [Low] KVM: PPC: Book3S: missing Fixes trailer for TCE hcall detach
  race fix
--

commit bff0a1814a06b4153499fc640facd0cd8bd3623e
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

> KVM: PPC: Book3S: Synchronize TCE hcalls with IOMMU table detach
>
> TCE hypercalls traverse stt->iommu_tables while VFIO detach may
> remove attachments and return hardware window ownership before
> in-flight TCE updates complete.
>
> Use the existing kvm->srcu read-side protection for IOMMU table
> traversal and synchronize SRCU readers during detach.
>
> This ensures that TCE hardware updates complete before the
> detached window is returned to VFIO.
>
> The following patch addresses safe reclamation of child entries
> accessed by these SRCU readers.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

[Severity: Low]
This fixes a race between in-flight TCE hypercalls and IOMMU group detach
introduced in 121f80ba68f1 ("KVM: PPC: VFIO: Add in-kernel acceleration
for VFIO").  Should this include:

  Fixes: 121f80ba68f1 ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126084351.3237=
5-5-nnmlinux@linux.ibm.com?part=3D2
