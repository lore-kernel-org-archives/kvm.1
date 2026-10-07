Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59A4825AE
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380788; cv=none; b=QMslS4hM+UvJ5o2RCtFH3LX6gut1uWS/S+T7GG2x1QzGM4D20YHHMretpc3DV7xV6CAWvusJ3MDvFSyJZBWdSh5N+3WvStbNodKIi8w2+q6ZCnw8fsKJmmOADMISPDRJ+xGuuuSe9opaEUvt0oCb2waWBcUJGLL46XSu0zIDz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380788; c=relaxed/simple;
	bh=EOLf8afyt5b6SOANC3rqCkf69jr4nV59FAjYhwNBzS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFVEaSxygQdo1PZpJZYwJsWKC3H567BSJuDI6hfQwE6j8rKmHZ3lHFMCnS7eYDPl82011vvAwrLW6xh50djhewT3lwRXU0ROEUgqIxPPhKf7nqWZMUbTLBLfG7j6mKkrQMV1ksqZe2K9ikBirZRYt4+QHcDJNURTKIEJu/Ex5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZcX6Ks9; arc=none smtp.client-ip=95.215.58.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZcX6Ks9"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EOLf8afyt5b6SOANC3rqCkf69jr4nV59FAjYhwNBzS4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791380776; v=1; x=1791985576;
 b=gZcX6Ks95jUcEVeEV/DeHEVvSx+xdQeZKfAijXps0Vy4fYo/fRKWLQ4c9Ccjo8ZMvmiKvwxZ
 JnGZUoefNkKskwLiN2mTKDTi5MKpxtiH3ulaSZuGgmhNgViEqmKU/Ikp90rT8OgkcVYGZVGGiRC
 Nx/eYmtKJO5WYPAbXXP2C+XM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31012733bd01e9b6;
	Wed, 07 Oct 2026 13:46:16 +0000
X-Mizu-Trace-ID: 31012733bd01e9b6
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so9223e87.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 06:46:13 -0700 (PDT)
X-Gm-Message-State: AFq9FYIv7Kvwhdq1BhBK+qCyEzM1fc+AGuLBgpG/aj4YjbdQ3jMFjUn3
	Sfw1K4xyOnSrVFQ62llxeG4rYjM4fCXm0+H1gaYSg/OynPnq9Xvfzl0Kth8CCJR9mL1CDjI/8Wg
	Y9dkBgIzKb+n604yKSGs73iQRvROe42S7SuBMKeZX
X-Received: by 2002:a05:6512:a83:b0:5bc:b531:51ea with SMTP id
 2adb3069b0e04-5bcca86c249mr304368e87.13.1791380772866; Wed, 07 Oct 2026
 06:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-14-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-14-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 15:45:36 +0200
X-Gmail-Original-Message-ID: <CA+EHjTy_1EekD472UH=CDSpC7oksdy3eS8AP0rPxKkhQ_PyXdg@mail.gmail.com>
X-Gm-Features: AclHuK_J8GmFTVM33wX7R0VP_JP-fZesKaU03j7TLtkYQU0t9fz-B9AOXRmoM04
Message-ID: <CA+EHjTy_1EekD472UH=CDSpC7oksdy3eS8AP0rPxKkhQ_PyXdg@mail.gmail.com>
Subject: Re: [PATCH v23 13/14] KVM: arm64: Mandate VGIC v3 for pKVM VMs and Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Wed, 07 Oct 2026 08:35:36 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
> pKVM does not trust the host. Realm VMs follow a similar trust model, with
> the Realm Management Monitor owning the protected state instead of the
> host. Add a helper to identify VMs that run under a host-distrusting
> hypervisor.

When I reviewed this in v21, the Realm patches that use this came
later in the same series. Without them, kvm_vm_hyp_is_distrusting() is
true exactly when is_protected_kvm_enabled() is, and protected mode
already doesn't register a GICv2, so this patch doesn't change
anything on its own. Should it move to the series that adds Realms?

Cheers,
/fuad
