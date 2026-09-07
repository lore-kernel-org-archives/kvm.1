Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B254582FC;
	Mon,  7 Sep 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779584; cv=none; b=Ikxsy4hr2vW9cPITePl1LrPx46agtcPQuUvLpLFyDeACCkMpIaulwijPzsRDRCCTpXGWcq3AgKoDPbkQJrf3I240XDVrTp1Yt6GYgkQRut4pA2/gBWBTE3Y+DmrUlTi5Gqj+DHYC6LSjuXPugmksoPUu0brtcpVEaQopK3C7Qcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779584; c=relaxed/simple;
	bh=EpBWm7l/SMvIb6B8I2VN3Q1p/tlU23eIdQVaFpkHoJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8tQitWKD7OHfVLZanluEIhp5aC12oA9AXph2GjVxm5QKuijjU5SNmBl47aFRP6C/2wyOaAy7Ncjk+wbCzf2XpV7u2InUmiUs/8n3MQitcmGnbwjBvre+anNhZG9RF/6u0IRz61RV7oEM4H7bqx8azo0k+W6Gv9IXNUDNpt9ihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=d+dCKFCI; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="d+dCKFCI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1788779582; x=1820315582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpBWm7l/SMvIb6B8I2VN3Q1p/tlU23eIdQVaFpkHoJY=;
  b=d+dCKFCIya3BdKpYQvYIya+mZSPrdpZgPAKwBfXMmsbZDkm23V9C5ec+
   Obr4iz8fXGzKbmlKDfn5YGtEYtKUZxJlSI/qUMtJ4QRiXcCTZco+ZF6+u
   M6kz1zXh1EqVudWfKIEngRP9S4zR9bGC4TbTojJpUzryk4cOZurXvJ4r/
   QpHuNhjJQovuS9TaK6IgRgLDai0Neyp/WnKq3W59FUH5EgI6SBoX79k0/
   pf8iEC+xxory9UU7OhqlA0vcE5VtrkPxrb2I5TZZ69LVgw6S28jdc77mO
   7D4fPNsYgbBo3KoVrtUoL9bhm+BBdcvARw03apyRdm/00Y+5Tobd12Bco
   A==;
X-CSE-ConnectionGUID: HceR5QNkR8q9w3/+IOq4EA==
X-CSE-MsgGUID: xu1KefRtRiq5Y7od3D5hvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="254198254"
X-IronPort-AV: E=Sophos;i="6.25,267,1779116400"; 
   d="scan'208";a="254198254"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 20:12:54 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B61178204C0;
	Mon,  7 Sep 2026 11:12:53 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 6A1F9C0054A;
	Mon,  7 Sep 2026 11:12:53 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.144.219])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with SMTP id AC6E01800102;
	Mon,  7 Sep 2026 11:12:44 +0000 (UTC)
Date: Mon, 7 Sep 2026 20:12:36 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v16 22/45] KVM: arm64: CCA: Handle RMI_EXIT_RIPAS_CHANGE
Message-ID: <ap6YrZiCdS6FI83p@FCCLS0092175.localdomain>
References: <20260803134403.80630-1-steven.price@arm.com>
 <20260803134403.80630-23-steven.price@arm.com>
 <ap49Orng5-oehc6J@FCCLS0092175.localdomain>
 <86fqzl4biu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86fqzl4biu.wl-maz@kernel.org>

Hi Marc,

On 09/07 11:10, Marc Zyngier wrote:
> On Mon, 07 Sep 2026 06:05:29 +0100,
> Kohei Enju <enju.kohei@fujitsu.com> wrote:
> 
> [...]
> 
> > Although the root cause is an RMM bug, should we also guard RIPAS_SET
> > against this no-progress case?
> 
> No. We really should *prevent* the kernel from using a known broken
> RMM. 

I understand.

> Which brings me to one of my long standing request: how to we
> enforce the minimum version of RMM that KVM is willing to work with?
> 
> We absolutely need to have a hard deprecation mechanism in place
> before day-1.

Agreed. Such a mechanism is clearly necessary.

Is there any ongoing work to address this that you are aware of? This
seems like a fairly broad topic that may require a separate discussion.

Thanks,
Kohei

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
