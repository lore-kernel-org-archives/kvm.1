Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394723B38A0
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908335; cv=none; b=gwkxJ8/jU6fYpVUtZ+FW5fqEsWPflzNin7g3I64efqbYTOl68ZlvmAXfs1zaa95zgAbuov9ThFSqj3EcYi/G9yD/UiYsckZPJsvmEcxytOsM9lMqDuRPevvOiNqXk7J8ZKRqaG2ZZqeTBysDltgbNQSohxjBoPXJ5XE0Q+6KE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908335; c=relaxed/simple;
	bh=Z6FV2ulius65EZ00KM68IIkPKjtFBNBgEx621yVlFgg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ckfxeiayXlymZZ5wIrmcudN+3k96uRCMgUvhuh63uEIiT5GGhJkmAzzHKr3wxQR222IzwNASyZ3LxIEtAfZbwfs7E1Pg8BG0DxPgi5XSWYqqLlsaYJydaPBOi+s6M2kvCdlQOTEwV5GM6ITx8F8bOaFBdwluVjr0xxxaPVfCroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfmvpaQO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hq3Mp5ik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfmvpaQO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq3Mp5ik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776908317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
	b=UfmvpaQOMQbo62K/XBAk9ecs1YNvo2HdfKxSlysKQeioQNeQf/21mjyr/Z5f390m33MgIP
	YzvQMSJmO8mHaijKShAnVa33U+aTfZz15Sgzp2goGOatkTLTk79vssHErXoG3kaS7XCb8o
	+7UqxYxs4S2gkKDd7bbG/DiqZTPX108=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-gy5sfbzrNOCjydPtoltm5g-1; Wed, 22 Apr 2026 21:38:36 -0400
X-MC-Unique: gy5sfbzrNOCjydPtoltm5g-1
X-Mimecast-MFC-AGG-ID: gy5sfbzrNOCjydPtoltm5g_1776908315
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b7aba0af02so784595ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776908315; x=1777513115; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
        b=hq3Mp5ikZJqQLhUlzhHJmK/yrkCY5ohjgjbYK7JvaW0hh/tdVBVcyVu67tw5H9D6Cd
         voanvF+b4EWp/MIL4itD4St9dKwbXgT8NlQbvACEpyns1c+uKbvROUQXpCvQd5OrED19
         H8RyiXq2xQSrX7T4KNVezwoSWlfWoAeH2uJb97MDWNeK/rE2EryAZmnimOvvLinehTmy
         VpOl7JsnBxmESgNbti0ADK+CZc83e05k/64UHrq3Ew/QpM6In1Eg1MqgdOQfT188F5EX
         p4VQhTuGEMiJF4h40oqU1giPgcc237KaH7thSpCtO51lK8o0mz1rtoL4lMDkxXHeo5Pz
         fQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776908315; x=1777513115;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
        b=GGWkST3/zCqu4set8dpXHZyfl5O0fTuTfIZ4okdyt1NMXMaVwr0VXY73NKWoViUL97
         paCP+VdDLySyzv8jgAUQGIQ/61Gfdlge5DbAJBxJVIC3vwx/kBEdB+3PdNYTgNgi3YLg
         oNxsrlJ++ngsaigwRbxPIFYZ5wbrPsdSLqXJu6uMsPZKf1++wEeg6VR2QMfKVnRQmfc+
         NIjh+7YSYSeAuItxBo523g3w/S/efM/zoOO5Q48XQzsvAhftBEqmmHmqj0JMJKBpmlYi
         0U8G8R8Ubosu+cbN66oHxIvQsIsiKIcDa/x2BELq8FF1t+gRDeabE9OhPfh9Z/tUWHIt
         dPHw==
X-Forwarded-Encrypted: i=1; AFNElJ/keGEI42avWjV8GyseuXktbJe0CmB1Zk2FfmoEJmLXKcsXdlWhDM92BbNo7jNS9iBn3es=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYUUEQ+tpiLXsEDJcOv5/WQy+Fy/LBsEKMMbIWVRv4hAz6Gv+
	iiVP/T5BqlRYpj4yqqnuyga9o8FhyL17UFQ+qwQPcseHjBmUdS1rmUSiARitCBg2Za5g+nMiDzi
	LBRLzBrcQkKDyyL/DU3BuKEaAhoqSO1so7whEcW8Ssht0N2BqKiHUbZcJUOYUEw==
X-Gm-Gg: AeBDietxo7NCifBOlasec178so8fc5sCClSlmfHoF6+U+reJsjfkvdGjsgGTb2LNd0J
	HdoQb95+1PZoX4mkLaIZvvRpjyNmW62vozW7LiHnaqxQv9XV/7ojvrzfo/3LcLNG6TCVp09ozCo
	dUI5yNA0UfEIb4foliJ03HVLScibUQw9Xv1N4DPPvOfjkzVy9bw2rFzjvNxW55XF93SzxpcJI9X
	xehpPtomKTQKDFYzgw9U+bfOATcj4vPaLDjUK7loEy/+89WSADZ6Aq3kFuieqZC+cuSIKyGAKRF
	rWO0v5VI6pVKwACTj6R2z6W+j//JDKirzabxzwLJlgrGxqvy67aM2A0wn7911TgaCrfYUe9A4n7
	1HXQiAjAN6LMeEQM2vAWvJR470Gh7OUGKgm/djb4x8Y1OkAmbjrK497GPf587SXEGf3FWnRPJbX
	vgqHY/TukzirggNUfS
X-Received: by 2002:a17:903:2ac4:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2b5f9f3c616mr257135005ad.23.1776908314605;
        Wed, 22 Apr 2026 18:38:34 -0700 (PDT)
X-Received: by 2002:a17:903:2ac4:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2b5f9f3c616mr257134655ad.23.1776908314054;
        Wed, 22 Apr 2026 18:38:34 -0700 (PDT)
Received: from smtpclient.apple ([2406:7400:56:9d52:1830:f5d:7353:6235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa17632sm184179495ad.24.2026.04.22.18.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 18:38:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.1] accel/kvm: refactor and clean up
 do_kvm_irqchip_create
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260415063835.85540-1-anisinha@redhat.com>
Date: Thu, 23 Apr 2026 07:08:18 +0530
Cc: peter.maydell@linaro.org,
 philmd@linaro.org,
 kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
References: <20260415063835.85540-1-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)

Ping =E2=80=A6 Now that 11.1 dev window is open.

> On 15 Apr 2026, at 12:08=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Refactor do_kvm_irqchip_create() so it has specific return codes for =
specific
> cases. Clean up the logic and add some clarifying comments. Adjust the
> function call logic accourdingly. Should be no material change.
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> accel/kvm/kvm-all.c | 48 ++++++++++++++++++++++++++++-----------------
> 1 file changed, 30 insertions(+), 18 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 92af42503b..788cbf8693 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> }
>=20
> +/**
> + * do_kvm_irqchip_create - create irqchip
> + * @s: The KVMState pointer
> + *
> + * Returns: -errno on fatal errors, 0 on success and
> + *          non-negative on non-fatal errors.
> + */
> static int do_kvm_irqchip_create(KVMState *s)
> {
>     int ret;
> @@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
>     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
>         ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
>         if (ret < 0) {
> -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", =
strerror(-ret));
> -            exit(1);
> +            error_report("Enable kernel irqchip failed: %s", =
strerror(-ret));
> +            return ret;
>         }
>     } else {
> -        return -EOPNOTSUPP;
> +        /*
> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
> +         * present. We can't proceed. Bail.
> +         */
> +        return 1;
>     }
>=20
> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
> -        fprintf(stderr, "kvm: irqfd not implemented\n");
> -        exit(1);
> -    }
> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>=20
>     /* First probe and see if there's a arch-specific hook to create =
the
>      * in-kernel irqchip for us */
>     ret =3D kvm_arch_irqchip_create(s);
>     if (ret =3D=3D 0) {
> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
> -            error_report("Split IRQ chip mode not supported.");
> -            exit(1);
> -        } else {
> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> -        }
> +        /*
> +         * If we are here, it means we are going to do an in-kernel =
irqchip.
> +         * Lets make sure that the kernel_irqchip_split setting is =
not set to
> +         * split mode.
> +         */
> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>     }
>     if (ret < 0) {
> -        fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
> -        exit(1);
> +        error_report("Create kernel irqchip failed: %s", =
strerror(-ret));
> +        return ret;
>     }
>=20
>     return 0;
> @@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
>=20
> static void kvm_irqchip_create(KVMState *s)
> {
> +    int ret;
>     assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>=20
> -    if (do_kvm_irqchip_create(s) < 0) {
> +    ret =3D do_kvm_irqchip_create(s);
> +    assert(ret >=3D 0);
> +    if (ret) {
> +        /* required kvm capabilities missing, we can't proceed. */
>         return;
>     }
>     kvm_kernel_irqchip =3D true;
> @@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>     }
>=20
>     if (s->kernel_irqchip_allowed) {
> -        /* ignore return from this function */
> -        do_kvm_irqchip_create(s);
> +        assert(do_kvm_irqchip_create(s) >=3D 0);
>     }
>=20
>     /*
> --=20
> 2.49.0
>=20

