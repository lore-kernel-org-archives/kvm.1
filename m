Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635581;
	b=cK2DYjVVB0IgYRQ4frh+YOvu+TYwsE5zWlYBGr/YFovx+FIz+QbyF6MJQNmPsDroom4S
	 jfxZ0RHt3TrJD55sf3Q6JA4Saqlw0krOVQFj/VgLA/SKj/CrjMMfdcoqteGHepW+8h3JJ
	 QmjE/NMSwR6njO/H8dmMJc+48xJV6AEWW32zGDySsqRhF8f5MTeAqZA7HyJcBHhvpu76Y
	 iewX9X+JZ4gf1EINwjQ0rP+kfnolMn4g/e8b/5ED/vuel4O7SNW3X4l6ThQx8CgDGls33
	 OZBvlZ594/MRF3ZXDdaGZWfuDiATqzFeNdLsKTCKGSIkGqg/0dV0u9aZVuutEx1dY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635581;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QqnvH/MqNkXeK1gW5SdVC8+SGDj/xZd6UpzikU80LiY=;
	b=SMNKc/bv4eI+wkqxFNzHDxZ9V9AdCl2aQ8Ax/6Vz+J/zoj+keMNmVv/8k6qKunVHfNbM
	 4l05m9NVbbqetwC1z77ss++za8YJX+I1kYyLZ8ENMkWCQ4Rf//BKWmHdzL44Fi1mUwjVN
	 +H6ksKrOvrteVV3Sqn5iDSqcOfdlrwWu1Xyq4GKjNZIQlDDGf7sK0Qy9roCFSChJL4zGk
	 8gmXlzzvDp2qgoRm4QBjfwxKwO6JjjvanybXp5Mu4BCK6JKiN794WwKVrer63WPGGXYmX
	 XJFTtBpAMgDe9KWC5P9Hyg8Z4nfrjuERUDyyBnpHULaQ2ihG5bFZNZD2KMjVH56+Scg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHsqar4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377D60703B9
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHsqar4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A21F00A1C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635581;
	bh=QqnvH/MqNkXeK1gW5SdVC8+SGDj/xZd6UpzikU80LiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EHsqar4OZin40FmNLuZlxJhrteSXmgAmiT5AmxaJJpwBfhxl014dApjq2op+v4IqK
	 e6K9fpH5YdJDvb0mj+g27DQ50JrjctrZ6cZYwO3aX/Ze1gXHOjaqOhm+YecevvmDiK
	 fjiMzIN/2wdNuRbsnUqR7MrSJJqAYKSZ1205B4tsqMEKlzne8aP+O4cmTYa22W/jOy
	 CiWMwZKE/kLxP8ByB6E5irvNm6iaRYZredKlxi9sJjxnEwU0IeSzv0Tzk9q/oNesDk
	 oSejId4sI60dw8Lvw47t6VtNdDVsPQfarF6xWF7c7j5Ej5bHS9xOmQfUQRscg1Fa66
	 dFx6ZrzdRUEiQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930c0f9c1b1so333855485a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 08:06:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzi+kOvuWAH4Qqo12w4W21ZIk4JHZa0+KDezFTpZPMWHBihlNZOid+QLbrjXPsTbR6PHbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvU3eC4kQsUGKe8uoKszNJPI9i19YAtASffcoiPuk0qFehdPgd
	KXzaB5LwklTVtv+i4OeE9vr7FMbMGZ5JEIHbCavC/ctnYQxiKMtkubYkFhaiOW3UYiI2ngTz6gV
	TWwYAb6eubCKEfEboJjpZzew3rZ2taX0=
X-Received: by 2002:a05:620a:2603:b0:939:fde0:a71b with SMTP id
 af79cd13be357-9442135c728mr1776147885a.0.1793635580647; Mon, 02 Nov 2026
 08:06:20 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHCio2jc9++n2Qoa0-sNkObZsWOybSwK1X2aBjFirchjRTBZsQ@mail.gmail.com>
 <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com>
 <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
 <CAO9r8zOmH6yzcNbUOF3FoNsac8rtx47rp5wByOFfGgaBPaLxug@mail.gmail.com>
 <CAHCio2hTSuTf4HcJ=+wb=_EQvi2as9QMwfRMG5tUkdCmex=yJg@mail.gmail.com>
 <auNvmlmXeWPh_HKT@google.com> <CAHCio2gdqdyGcGHN+dN9hzoj_0-XSKYFS4ruFrLU+DMG-4XooQ@mail.gmail.com>
In-Reply-To: <CAHCio2gdqdyGcGHN+dN9hzoj_0-XSKYFS4ruFrLU+DMG-4XooQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 08:06:07 -0800
X-Gmail-Original-Message-ID: <CAO9r8zO=_BEefcwX6vzP7own7EmhLwrRCD=hFOB+Lejm2B=BNA@mail.gmail.com>
X-Gm-Features: AclHuK8caYq9pYxNRvdAhsGalfBjqfpcIU76PPvS7EupwNesk8FaG1ZmJi_UgO8
Message-ID: <CAO9r8zO=_BEefcwX6vzP7own7EmhLwrRCD=hFOB+Lejm2B=BNA@mail.gmail.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
To: Jackie Yu <ufo19890607@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mlevitsk@redhat.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:20=E2=80=AFAM Jackie Yu <ufo19890607@gmail.com> wr=
ote:
>
> Hi Sean, Yosry, and KVM folks,
>
> Sean, thank you for the reminder. Sorry about the earlier formatting.
> We will use plain text for future mailing-list replies.
>
> Yosry, thanks for clarifying. We understand that by "missing
> emulation" you meant the INVLPGB handling needed with distinct
> per-vCPU ASIDs, not a bug in an existing emulation path in our tree.
>
> We agree that intercepting each guest INVLPGB and issuing a separate
> invalidation for every ASID in a large VM may undermine the benefit
> we are seeking. Using per-VM ASIDs consistently, rather than
> switching ASID allocation models based on nested usage, sounds like
> a promising direction. Our production guests do not run nested VMs,
> so direct execution before nested use would cover our use case.
>
> Your suggestion to change the INVLPGB interception policy when
> nested virtualization is first used is helpful. If EFER.SVME can be
> set before a guest runs a nested VM, the first VMRUN seems like a
> more precise trigger. Would KVM catch that VMRUN before entering L2
> and enable the necessary intercepts across the VM before any vCPU
> can execute an INVLPGB requiring nested handling?

Yeah we can do this. For example, we can have a static branch in the
VMRUN emulation path that flips between a synchronized path that
enables the INVLPGB intercept, and the normal path. The static branch
might be an overkill.

> Could those
> intercepts then remain enabled for the VM's lifetime, rather than
> switching back when the guest leaves nested mode?

Probably? I think we can only switch back when all vCPUs clear
EFER.SVME. I doubt it's worth optimizing.

> We realize that
> interception would still require correct nested instruction handling.
>
> For context, our experimental KVM4 configuration used a VM-shared
> ASID and separate, out-of-tree guest INVLPGB passthrough. The
> madvise() latency measurements were:
>
>   Workers             INVLPGB off      INVLPGB on
>   64 mean              21.624 ms        12.505 ms
>   64 P99               32.760 ms        21.518 ms
>   128 mean             29.553 ms        20.459 ms
>   128 P99              39.628 ms        28.160 ms
>
> These were single sequential A/B runs with 64 allowed CPUs; the
> 128-worker run was oversubscribed. The results measure madvise()
> syscall latency, not IPI counts, and do not quantify any additional
> flushes from vCPU switches on a physical CPU under per-VM ASIDs.
>
> We can share the benchmark source and run further comparisons to
> help evaluate that trade-off. Would the maintainers consider
> consistent per-VM ASIDs, with direct guest INVLPGB execution before
> nested use and interception once nested use begins, a direction
> worth pursuing?

As I mentioned, I (not the maintainer) have no problem with per-VM
ASIDs. We probably want to make sure we don't regress workloads due to
the extra TLB flushes when multiple vCPUs run on the same pCPU tho.

Other than that, I don't want to rework my series to go back to per-VM
ASIDs. So if Sean and Paolo are okay with per-VM ASIDs, I think this
should be done as a follow up work on top. Just my 2c.
