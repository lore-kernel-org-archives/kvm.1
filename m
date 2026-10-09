Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F03BB134
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532719; cv=none; b=L2jE3ySZo3kLZk5cbRHfsA0sA+03hvcPrEV/emwoA4HYx/M+nR1R1re2woeeqMOyTAP57PahtT2roJQLHsHl6FxQNypssSiVNK2vzmoglDo5NWaVgDq+yFWac8R0jgkfzDIWORWGlw0NJ9dGrK/nUP5dGcMvcIOkf3o4r+S6bW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532719; c=relaxed/simple;
	bh=HOVfYS51lkukawzGBUztER+emMA6ntCgIQIvA0pUhsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfVhGn+3ko5rtPGWXDygGRbH5M537eMzHirEPmVowU289GgqDNWW4eQBM+v0N0igsri7m0018h2DhtX7Fq/GoJfIgm9csH/uAKwMwZhzM5ivF602Sz+DDnLUuXJ/4k8q9EFB28jioFyYUh6CWwrC4H/rte1fSJvDrjZA1Zm5Xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rSUZcRFy; arc=none smtp.client-ip=95.215.58.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rSUZcRFy"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HOVfYS51lkukawzGBUztER+emMA6ntCgIQIvA0pUhsU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791532713; v=1; x=1792137513;
 b=rSUZcRFyZL1Q6Aih7nKyp6YCoB9RVxhLUK5KWevCJeI2jlZanH+LM4X3bgOb+g1fCEvsithM
 4cdlKf9M+6vNFLBw6dIRh9I7/mqo+3eKsHBpb6z7+1gMQ4JuodbWjkCeSJeEirQPGwWpnoRjms+
 UtKIVN7dAMO8ewOLTxgclPTA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0a40b8ad170843f;
	Fri, 09 Oct 2026 07:58:33 +0000
X-Mizu-Trace-ID: a0a40b8ad170843f
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so4961e87.1
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 00:58:33 -0700 (PDT)
X-Gm-Message-State: AFq9FYIFj7YOvo+IUl337HYsXiMbaui2/zmeqM6t+Sji9vULnV2qjIAp
	SzwFh+DF61+xIg77hnyt2p3i2knOq4KAQW2o3+h9+Z00ZafIxla8nxOeI9vpnEskKFowGkL26kO
	Yvz2FLVnJ7c5lVzC49yCE6o3w79os9Q7lmfaU+KRV
X-Received: by 2002:a05:6512:3b2b:b0:5b8:d830:be30 with SMTP id
 2adb3069b0e04-5bcdf978106mr42003e87.16.1791532712487; Fri, 09 Oct 2026
 00:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831192406.1341841-1-fuad.tabba@linux.dev>
 <CA+EHjTwBXEVp_fJp+SvXqrfab2NGdnCXy6L9n=aW2yeTUUOniQ@mail.gmail.com> <asidn0tpusz-MZRp@willie-the-truck>
In-Reply-To: <asidn0tpusz-MZRp@willie-the-truck>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 9 Oct 2026 08:57:56 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyHKLZ8fJ4dEmrx1XLe9=XdhYytMFzn9pTRMaJGoa=FTg@mail.gmail.com>
X-Gm-Features: AclHuK9PqZbjeow1kT94C7mAFJI1dY9tubORoAFM4lnPAOqIjEyuT7gh9MDDRW0
Message-ID: <CA+EHjTyHKLZ8fJ4dEmrx1XLe9=XdhYytMFzn9pTRMaJGoa=FTg@mail.gmail.com>
Subject: Re: [PATCH kvmtool 0/5] Fix diagnostics and capability probes for
 protected VMs
To: Will Deacon <will@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 08:54, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Oct 09, 2026 at 08:10:55AM +0100, Fuad Tabba wrote:
> > Gentle ping on this series. Marc has merged the pKVM core series into
> > kvmarm/next, including the KVM_GET_ONE_REG -EPERM that patch 1
> > handles, and all five patches have Suzuki's Reviewed-by.
>
> I usually wait for the patches to land in Linus' tree before I update
> kvmtool (although I may be fishing when that happens).

>  (although I may be fishing when that happens).

Took me a while to understand that part :D

No rush, and enjoy the fishing.

/fuad

>
> Will
>
