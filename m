Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4B314D0D
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259494; cv=none; b=rreW0YeEIxrKpLo+LmRU/GWlrDduygPW2cRlNBTnZya33MmfdA3w7K+S6/LVOnagg4/eOxuArPX7xM/rJwfR/dhH1Kkf8NUFIt6fTMSKvPwHVIbWbBYuSULFhBFSOkd3shbdErSRdx0vpuqPNLgq436ZO6KjuiX8KpJn+tVeLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259494; c=relaxed/simple;
	bh=VUkVhekypmrA/fm3aT/AOXVgI0Jp3hr9dpfxp+kFM24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aD4t1GvUZRoP2KiQbFtq77MjMrREJ7yDZIptynJrAS0wXlCriLeSx0B+R08nidPTl1zV2pT3xy5SfTigkD90mkKIEx8eZQMKH1f5uQCvw/NPfX9Ecs2u1QszroXMBLyV+II8Gb0fl+CRIIi+NY966wQO6N9uDSsTPw/aiPYaXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok1MYwsL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok1MYwsL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so1682620b3a.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775259492; x=1775864292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPRwMLyzRNda7Vt5MnDbMW9ydqG0G9tZQZkm3uF+YwU=;
        b=Ok1MYwsL5Zxw1R8m6AKDqSdhaU3hePy94JUZVFJOWtFsOPHYKLINLTnKNexX4DIKLa
         WUGLY5g0V9Vu1/XGgPAoveoSR+oLENLbIwrSdqVqX+kaU01XPOpbeOA9ZfWN/4Vc9OSa
         hP1kDsyGMpUyDPqszDmL2+cf5H9iPWbQ1HNHnsC771i/hztKU6LwTrAp8Pl8pbvZfp8e
         u0wrfk1zr3kq0P2CrU5rqlvIUO4XXCA37oXFI7JWxVxA0W81gRWfPHefoleYDu3mpsGY
         zJsj0FtLR4U9EsGo4bQ9CQ7i+O6Lk8iXNfzXQ4AjUv6km28412rL9VRyYqV8VqwhIETx
         bafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259492; x=1775864292;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPRwMLyzRNda7Vt5MnDbMW9ydqG0G9tZQZkm3uF+YwU=;
        b=fNjuEn3vWwxAWwH0OmCFqaNimQz+tYu1GNjguENj8wV+ub53EB95/gktDDDcI+RIHu
         +MC+S3p+sIOU2cGjcpgrVW4Sf1rnUZpdq0DtIoDJs4YTHgCWydx7v2rIB2qFYTKy29eF
         ioCsc0VJu3D5eroNOv26PWtnueDZ86/hf/wv3hfdf3H498i4SpStyVnvL+L04tW5HaU/
         4DcBFD7WKp1JelAXhx9Oc3b5Xq3cGVBPzEcKcQdUVFadY+LbJbueB63OXevXDFduuYnD
         YMLmu3zV/dqwRTIXIXgm3QVB2ipEj8M7nrq9yf6AtdzbCeDjyYiS+V/SpI7z+iz2tylV
         EBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyR40apkO+V6D8uEUNpGTBInzaQIFzpfkuDK6khC4mH9/IzBJ66ZxwpUZDlOX2cRYuyiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryC9Q5tuXzeZsihAvzeLtozdWxwqVzusqUCMs5ibwZ47+AmA5
	ajhkbP0jGcg65Xf1JrmrB5NzMg4kvDaFpQk5/fGBOkP0c7autoapKKbW7Wka3YEhsioizsycRR5
	USiDeOA==
X-Received: from pfll8.prod.google.com ([2002:a05:6a00:1588:b0:824:bb96:dae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2290:b0:824:1b66:6ae2
 with SMTP id d2e1a72fcca58-82d0da2e936mr4877838b3a.10.1775259491997; Fri, 03
 Apr 2026 16:38:11 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:38:10 -0700
In-Reply-To: <20260318143112.4ac13424@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313122040.1413091-3-clopez@suse.de> <20260318143112.4ac13424@shazbot.org>
Message-ID: <adBPYqunQxc1CujB@google.com>
Subject: Re: [PATCH 0/4] KVM: VFIO: use mutex guards to simplify control flow
From: Sean Christopherson <seanjc@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, kvm@vger.kernel.org, alex.williamson@redhat.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026, Alex Williamson wrote:
> On Fri, 13 Mar 2026 13:20:38 +0100
> Carlos L=C3=B3pez <clopez@suse.de> wrote:
>=20
> > Replace several uses of mutex_lock() / mutex_unlock() pairs with mutex
> > guards, allowing removal of all gotos in virt/kvm/vfio.c.
> >=20
> > In this series I also include a small refactor that allows greatly
> > simplifying kvm_vfio_file_del(), and skipping an unnecessary call to
> > kvm_vfio_update_coherency() if the list of files managed by the KVM
> > VFIO device does not change.
> >=20
> > Carlos L=C3=B3pez (4):
> >   KVM: VFIO: clean up control flow in kvm_vfio_file_add()
> >   KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
> >   KVM: VFIO: deduplicate file release logic
> >   KVM: VFIO: update coherency only if file was deleted
> >=20
> >  virt/kvm/vfio.c | 97 ++++++++++++++++++-------------------------------
> >  1 file changed, 35 insertions(+), 62 deletions(-)
> >=20
> >=20
> > base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
>=20
> Series looks good to me.  This is nicely isolated, so I assume Paolo
> will take it through the KVM tree, but I can also take it through vfio
> if preferred.

I'll grab it for 7.2, probably around 7.1-rc2.
