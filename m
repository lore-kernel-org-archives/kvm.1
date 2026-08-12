Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F383537C7
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505141; cv=pass; b=qf8YLpGJ8zH5dPbLahqmqkS7GXMvh+9ra2HSrwcFZwW0AQp5kWKoiRoUDgRfDh7e2Tavx1XAimO0wYqbM0ea/Hc0doI+1zno54QnSuyO4BwIILRU88f8EbQZpFqUWNDZB9igD7OehOONVXMjlzdx2r3S4NAgrOuF4Yar2nxBy7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505141; c=relaxed/simple;
	bh=8eBdffJzIDgLmDfD73g8in+j36Jkh74FeOyl9b2izWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM/Da8dgkPUU66quIqTLbMx1iq/pHmhNvR7Ia/duKo3J8IMitLSQxxVF7v59wA0uKseYbfHC05EhNtVwwhkMhOQfJiskNpHBhwsHs2/dZpCQmD5vneuty6Q5Z/WhdEcupsHG0BW6TZFr4fQhWfLb+Nln77lOD8C3GwAf0wxLyLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THo5ML8s; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THo5ML8s"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f0e5e36912so2920096d6.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 20:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786505137; cv=none;
        d=google.com; s=arc-20260327;
        b=lFe1c4Co3XvjSwTu6fPDcwoPOii3Cd3WEovc96aQKHXuIbfsmLlnBCoUUX4Hbl/xa+
         68XkyZWr/KqNCU6fQcmUGoZJNvxReq3+jcWQGivNLFN5NIikd9Mr3AQjDm3dO27yACpz
         F1nRDI6rkcmXKbEc2w06T0flUTaQR6UCwBQa9ThuGwKCgD1vbu/SOX2FANozzmNPMjGV
         iXLSqZ/4d9t2uybtko7hyGuIWr2P67wNW31GAonOQnp63pgNh1TcT8r0diDcX1Xzso+Q
         3Htur/gVabGcFgBHIKnzJ+U/PwazgREJaFYdbmORFrMQxsRZXFqEVcQPa0ADm4Cu65KU
         FBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sbAE3LPUDSURazUhNIkFniQu501TuI9sZ6Nx1+2SCHw=;
        fh=2E06lHY2nuelWacMpEcsUK5UkVbxcbDXIDQBfSqvggc=;
        b=BfFpwy4GNiDplnFTEK0YQuFTPUNKc2TimUAyUJUoCBgpgCJ+SOjFhIhp9Rd6yw1svX
         Zq6v2eSkZ6vTuZxT9Jvyd2WrcMFaBC0ficFAXbw8LvrcJA5ku0xhbgpqeNMkNk21jseK
         VjRnlVCMBG7CHpy//O2TVeWUJ8kJ+Gl/n64DI1njTH3dOb3ds3GVO7ZIhy2zNYUOqSvd
         9FHKKHjY6pIndB/sXoerauyxF5yOu9bK12AxA5KfBls9xeOLBsO4qSivEBmQcNsoyWok
         6Fva0ynJH9q1lO4rY4oIWBSUxvl//XcnhAwIR9Rfwn7+VuoGlx1ndMTXfSeGsTjjHxzL
         qjDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786505137; x=1787109937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sbAE3LPUDSURazUhNIkFniQu501TuI9sZ6Nx1+2SCHw=;
        b=THo5ML8sZEQniRgq49hU4bPM9T9WCE0q13iS3V2sIQGam/pghsm02ra/a91mvrqWU6
         5AGk5Gr/bP63Vuur2NBmJ2HYAyXNfb1Fx6IvWdZ8FaAeZAK7aTTXHppkdQ5MWZi2tOy/
         aQjx+2SPPkvkfQjnfw4uqQBGY4GaIHLguOi6QB3m2vBfH/3fun2/Ov46mMoArH2FSWso
         9WIKZM3jtGIPSVb0w06eLg9i4qeF5auijzQ3b+YFN4AnCALG0Htlf5bC87td1X3hceZl
         cXy/MzXrc9PhOHIR0fS8cOOGngIJtgEG38WCYC2WWwL2yu5Aidt3tRcnVYe1UbfF/eFV
         3Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505137; x=1787109937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbAE3LPUDSURazUhNIkFniQu501TuI9sZ6Nx1+2SCHw=;
        b=fEz0sd995PhMhPOAoKaiHKNQUt96LcMCeOSnAaZt2E0ZhmGfN69feX/D5pJ6eao1ex
         Q4ba9pncpMU6jKZmjlBHEitkglp+mlrTBs2jWI2ndiDOR/+CSxmNJ2Wc4zU67aeYaocA
         ek9Cp86BptUF+fbSBknpT0+ZjFaHmRZTSjCEiSpZt8P2QhWuqozLmf+oS8Ch0tZL0b77
         XMV9HF7f9Ph1ErkqEIXD2tNc9n265AIxDinpcoYE5ASJ7I4zS7DTd0ea0r6Oo+lVeZW0
         ERJTj0mcP163af6uKaAlM6Rn4vFq14dFwdzvBI5IoYmmuux0NH+9wkLk4NxJ4eeVfQEi
         DctA==
X-Forwarded-Encrypted: i=1; AHgh+Roi8Zl2up24pc60zbWV1BvH4JfzESCDnAsONUSH53LneqwqrjurTsCcl5PsebaBCPx4fBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOZaw5joqYQCM2cpWMiTE/idUwGqvavzXN/T7jb7GkKQ4w17g
	d13LUcoqqT6knVrgQqM54CVd7xU4GIVKn9Z+7quoRp5Q+04SvEVcInGdghITtEJ8/jbSi3wWT6t
	itv0TfyD3llcMYsdtdF48wK4NpD3S0AISYuh0WXPSeWMgre8tYTZ+RSqrkr0=
X-Gm-Gg: AR+sD12BZqThdz84bWOVdAysJcQdvAETstBrlELEMBAsiPm7QXbori7wlG+EKaVunBe
	y0UU/ZK3HOY1mtxWh54cK3VBrq/qyr17LQImpwNm1iM58/ShFf8nsd3QlwD1Xo+xnJymNmWggWT
	2Zd0mj51RP0jX+//c6eCJaH4uImvMXQIPZddB8NVyeMTR0ydISX7DS2UKuvn5fad61LyG8FZd70
	Ifa/2K+8hJCBbCssr+Jy8w9W3b4D0bo+mbyAN/2KFxV0v84vQCWhf/Z+tuv3BGZu43HSJBRd713
	wBrQdbmMKOzMS321JkaWtDTxdFofTWBQwYWx98iaLbBpip2rokZsaQub
X-Received: by 2002:a05:6214:230a:b0:907:c056:d63a with SMTP id
 6a1803df08f44-90a6ffd0170mr15698606d6.20.1786505136817; Tue, 11 Aug 2026
 20:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134403.80630-1-steven.price@arm.com> <42170467-fe36-4382-867f-49bdc6a7bc9a@arm.com>
 <d0ffbcb5-0cca-4d1e-9788-6b430345fa9b@redhat.com> <5e86232a-89ed-40ff-89e2-9e48fbf9554e@arm.com>
 <e2894206-7470-4606-b9ac-eedc8d2bdaf3@redhat.com>
In-Reply-To: <e2894206-7470-4606-b9ac-eedc8d2bdaf3@redhat.com>
From: Alper Gun <alpergun@google.com>
Date: Tue, 11 Aug 2026 20:25:25 -0700
X-Gm-Features: AUfX_mydHvtdt9zTnMQDxMEfQcPxjhamET6J18JMLKXgxKIfjEME9sN1_LoiXoQ
Message-ID: <CABpDEukGY+ctSi6wHAaC7o4pGmastX_Y18K2_VYDhNME7TF+wQ@mail.gmail.com>
Subject: Re: [PATCH v16 00/45] arm64: Support for Arm CCA in KVM
To: Gavin Shan <gshan@redhat.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:08=E2=80=AFPM Gavin Shan <gshan@redhat.com> wrote=
:
> As the following calltrace indicates, -EAGAIN is returned from tf-rmm::up=
date_ripas()
> because true is returned from s2tte_drain_pending() for the S2TTE corresp=
onding to
> IPA 0x80000000. Linux host received error (RMI_ERROR_RTT, level=3D3) in r=
ipas_change().
> Upon this specific error and the IPA range [0x80000000 0x90000000], find_=
map_level()
> returns level of 2, and realm_create_rtt_levels() returns 0 without popul=
ating any
> RTTs. After that, rmi_rtt_set_ripas() is re-executed and the above loop s=
tarts over
> again.
>
>    Linux host
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    kvm_arch_vcpu_ioctl_run                     // cca/host-v16
>      check_vcpu_requests
>        kvm_check_request
>          kvm_rec_handle_request
>            kvm_complete_ripas_change
>              realm_set_ipa_state
>                ripas_change
>                  rmi_rtt_set_ripas
>                    SMC_RMI_RTT_SET_RIPAS
>
>    TF-RMM
>    =3D=3D=3D=3D=3D=3D
>    SMC_RMI_RTT_SET_RIPAS                      // tf-rmm/topics/rmm-v2.0-p=
oc_3
>      smc_rtt_set_ripas
>        s2tt_walk_lock_unlock
>        rtt_set_ripas_range
>          update_ripas
>            s2tte_drain_pending                // true, returns -EAGAIN
>
> The problem is the pending-bit for RTE corresponding IPA address 0x800000=
00 isn't cleared
> when SMC_RMI_RTT_SET_RIPAS is invoked. I didn't figure out how this bit i=
s set and why
> it's not cleared in time.
>

Hi Gavin, Suzuki,

I think I ran into a similar issue on rmm-v2.0-poc_3 last week.
This looks like a potential RMM bug: could bit 32 be part of the physical
Address (if PA >=3D 4 GiB)?

It seems s2tte_drain_pending() in lib/s2tt/src/s2tt.c checks bit 32 without
checking whether the descriptor is valid or invalid.

In my testing, guarding the drain checks with a check for S2TTE_INVALID see=
med
to resolve the boot hang:
--- a/lib/s2tt/src/s2tt.c
+++ b/lib/s2tt/src/s2tt.c
@@ -1701,6 +1701,10 @@ unsigned long
s2tte_clear_drain_pending(unsigned long s2tte)

 bool s2tte_drain_pending(unsigned long s2tte)
 {
+ if ((s2tte & S2TT_DESC_VALID_MASK) !=3D S2TTE_INVALID) {
+ return false;
+ }
+
  return (s2tte & S2TTE_SW_DRAIN_PENDING_BIT) !=3D 0UL;
 }

@@ -1730,11 +1734,19 @@ unsigned long
s2tte_clear_tlbi_pending(unsigned long s2tte)

 bool s2tte_tlbi_pending(unsigned long s2tte)
 {
+ if ((s2tte & S2TT_DESC_VALID_MASK) !=3D S2TTE_INVALID) {
+ return false;
+ }
+
  return (s2tte & S2TTE_SW_TLBI_PENDING_BIT) !=3D 0UL;
 }

 unsigned int s2tte_drain_handle(unsigned long s2tte)
 {
+ if ((s2tte & S2TT_DESC_VALID_MASK) !=3D S2TTE_INVALID) {
+ return 0U;
+ }
+
  return (unsigned int)EXTRACT(S2TTE_SW_HANDLE, s2tte);
 }

Sharing in case it helps.
Thanks,
Alper
