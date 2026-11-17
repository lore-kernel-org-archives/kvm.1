Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794952221;
	b=gVhq69x8O+zj+tRcLyKcuQpDuElIUzB+6t6GRUnC1Rks8bp/VdM065qD4GYQu2bIXPaL
	 5elUkW7Q88zUf7Al6GErTWxWtilu960Fa+a0jLs8EAHXZcOgkMoEvjVRa+R5pOyH+c3NC
	 W9GOo/othTI+MzlqeH1Z7eGGvuoCyUOACNE93YQdaDXczB7TwFW1D01AsRknqE6TaCC/b
	 RepHY0kOe4zV5E9V6smkr2reNDFeBpMKA3e/71TiRTWUFrKov8ZlW0/hKwQP8akowy7Mx
	 +ZabqOoeJffve+Yu8tll6bcZcDhDYIs4JHOomY2GkT+2741wc7Jb4Z7BOpPpmHRjhrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952221;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=BtxvpbQQdhqiBSFhrkHNJl0wi8M/6pqGDRVhIboY3OE=;
	b=rnx+pwervOGX1R/2E65447h5E1aGGW4/nwfoqDD/V24fBPoJk9QDDmA/l+VsDxxUQk9W
	 hVIiz2rjnLZeNCgJfYFst4euOgWZ4GOrqvISdBbWez8fj8lw6OdUzrES4Z69WqpclxpOH
	 DqrYevTAxCM2by7Q7AltwMw7R/W1RiM/80zbEEu+QnUivl2vHr+FqVOzv6TfdxnjmxBD0
	 G8eIXIHr3KxpkDkjzClQFh8g4mesOaDI9Br4j+xQnB5C+iOhDkjDHqUidtSVziBl+tmQp
	 hA0yZ7ti5obe352B/peMf/anyOEeFQ3jR8May6csrSvlH2cVtd1cNhWr2Nh3dO6ahRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cBqCMN2M;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7879606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7879606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cBqCMN2M
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cddc597d062so208864a12.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952220; x=1795557020;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtxvpbQQdhqiBSFhrkHNJl0wi8M/6pqGDRVhIboY3OE=;
        b=xPvJ50bi2YGtlxK8NMCN7ftZrTJDR+jZhSlNkN5+bnruK1PifGBnXDys8UcgMxSwBB
         +f6QvVVpogMU23luTFHwnI9HMX+4WnWInlTrP/xDkhfK+9tDaB9xsffg+fIjEvkg8DFm
         OSi0Udhd1fiwSKFYy4ubpd9vGv9PnzfBhi2aYCM09DB41rbHU1N/mNC/nDE+Z9J62tSR
         d09LheldozTDYVpE3tFJBJxjDKhCbRGvJq8H4tqkzRrLxedlhtHCJoiW7DTTG1yUUbzH
         AQGwJ4hqx/HuY9Nbu1oA1PMPdxd+iQiWd5b7eZvYJrmChvjCkTxo3nHr/4XqOSalBkMW
         0dWA==
X-Forwarded-Encrypted: i=1; AL+hErG9/B5Vk4wJr1XMV7l4uo2u/5XFtl8Z7oUIsno5CTIjutSwojhyPsq/2bf/dIng3jQHCkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GxREyHmkb4c+eM/+E9c9DDuU/djkd8vwqXFePzVoDpu3KU2Jy
	Xv7LO9VsaV1LBjHFsqZpGXdONy1+LvNwTmHWiKdb1NNbGR8QrwbbYb88fTZfyVu7kzKlz4yhzao
	UaI972zdVDaj+vUvoGFC503J85j8reFdu3sO4BUSVNQGH0wis2P5uDwmbTNBBCnRAiU/ged+W/m
	zjg810hDUXZCTcxJap7sinnZkzHoM5HhjxGRpe3YnM85KY5DgskrG/jU66FVH6hIpuRdrbpwyXy
	YWR
X-Gm-Gg: AZFdTZfMAb3mupNNR9MZNKnmPkGaavXHI0UmjOTMu3aFXALTi1o7LVI7Yrx6HgXVcws
	w47LscKtN4B7tMNSJ6m+VbCMCaiFhHgAu6mzuqEhP+KGL/Q0z4t++DbJGPpaTa8ScNDrr0h3xB7
	+olCM8gfnxZnWCwnC/j0ButYLiKaRXiSOVm5oMUKhJQwgEDX8s4qhCAeiDo+HIohCxYWsJgfTUz
	uaDEo3tuQwLiOWV+xaPGJ18sfTsuGBVbRIrGXtxlm9RXGBJVoGH+OBtc4FAy7UhyjNIFb8XHiF4
	XvNEpJnx3ThbKCrQeC+ipym/YUkV/Zxia42Izrxks4k+a8IRLWAVjDbr5u7EU45STVX6V+P3/Y3
	vUQxTcM7eB9Tqzl+SvknjlP6lLMw8IEIvR3n5OQwqOlVJphzGY/LyGXzWVfIoKkbHya4ck+nM4B
	RNB8UlUktdcxVIAc6tNpU6+TcFU1Dhv11C
X-Received: by 2002:a17:90b:4410:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b3d07a25c1mr747006a91.20.1794952220061;
        Tue, 17 Nov 2026 13:50:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d19ca5b5sm188220a91.0.2026.11.17.13.50.19
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:50:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3adfcaea19aso2019151fa.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794952217; x=1795557017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtxvpbQQdhqiBSFhrkHNJl0wi8M/6pqGDRVhIboY3OE=;
        b=cBqCMN2MfbwyYOmOhDLs+jzg3hJ/04aWYqK8uramSLhVS76yceFZSsVUrLtPActcvA
         uTPe2KxpdgRXTIZdJaocRhCZlz2QTiWi8U19Y8MnT6EL/z7pjPOt6DBWo7Xs0LxRsuG2
         TNvgswGblCTdQrF/6LXrcllW1JC4eRv0KqbgI=
X-Forwarded-Encrypted: i=1; AL+hErES7NJdVp6Ij/LPyVXwgmsRu9R07OfyDnreD8/rkWoNR/9Yc0t/A4Zo1sP8tYFfao7mDBc=@vger.kernel.org
X-Received: by 2002:a05:651c:1615:b0:3aa:f42a:b78 with SMTP id 38308e7fff4ca-3ae671e58ddmr1423291fa.20.1794952217377;
        Tue, 17 Nov 2026 13:50:17 -0800 (PST)
X-Received: by 2002:a05:651c:1615:b0:3aa:f42a:b78 with SMTP id
 38308e7fff4ca-3ae671e58ddmr1423141fa.20.1794952216895; Tue, 17 Nov 2026
 13:50:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <4dca09deb85d2d5db157888ae4a2de7cbf6421d2.1794374897.git.zack.rusin@broadcom.com>
 <CALMp9eSARNY=K-bXSoV6sBBaWoKQGHtym1VrjnHtBQhFvsb2gQ@mail.gmail.com>
In-Reply-To: <CALMp9eSARNY=K-bXSoV6sBBaWoKQGHtym1VrjnHtBQhFvsb2gQ@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 17 Nov 2026 16:50:03 -0500
X-Gm-Features: AclHuK807et2ZoWk0xCaxLbuvndRbqzO3WiuIVD3kOgv5LnNqlCtYteaCfGFLgE
Message-ID: <CABQX2QNy0nZJtvJJdBTrKTTZB=gYpRGpy6Gmx=NF8mGc40b_wA@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] KVM: selftests: Port VMware backdoor coverage
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000053393d06607fe16b"

--00000000000053393d06607fe16b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:37=E2=80=AFPM 'Jim Mattson' via
BCM-KERNEL-FEEDBACK-LIST,PDL
<bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
>
> On Tue, Nov 10, 2026 at 10:08=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.=
com> wrote:
> >
> > Add vmware_backdoor_test, adapted from KVM-unit-tests' vmware_backdoors
> > test.  From CPL3, with CR4.PCE clear and no I/O permission bitmap in
> > the TSS, read the VMware pseudo-PMCs with RDPMC and issue backdoor
> > commands on the backdoor port with IN.  Verify that the pseudo-PMC
> > reads succeed and the port accesses exit to userspace only when the
> > backdoor is enabled and raise #GP otherwise, and that other PMC indices
> > and ports always raise #GP.  Repeat the pseudo-PMC checks at CPL3 with
> > CR4.PCE set and at CPL0, where RDPMC doesn't fault before KVM handles
> > it.  Skip the pseudo-PMC checks if KVM doesn't virtualize a PMU, as KVM
> > then injects #GP for every RDPMC.
> >
> > Run the checks for a VM that relies on the enable_vmware_backdoor
> > default and for a VM that enables KVM_VMWARE_ENABLE_BACKDOOR, and
> > verify that KVM_CAP_X86_VMWARE rejects every flag it doesn't report.
> > KVM-unit-tests can only cover the module parameter, which applies to
> > every VM, while the selftest also covers the per-VM capability.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Link: https://lore.kernel.org/r/aIEoNpe-LFoH6LBm@google.com
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
>
> [ ... ]
>
> > +static struct insn_result guest_inl(u16 port, u32 command)
> > +{
> > +       struct insn_result result;
> > +       unsigned long rax =3D VMPORT_DEFAULT_RETVAL;
>
> Shouldn't %rax be VMWARE_MAGIC?

Yes, good catch! Thanks. The KUT test loads the magic value there and
I must have lost in the port. KVMs L1 backdoor only looks at the port,
which is why the test was passing, but I'll fix in the next version.
Again, thanks for looking at this.

z

--00000000000053393d06607fe16b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFLx
Tb9m7nzsimqC6t0kgAYV36Amc4ovvGqgrnqQl1p9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExNzIxNTAxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHM91zEWWnY5VLC5Doy35uNLiZ/k6T7oZHP4P8VU
e5zc1DykZUQR1b/E6QeO3N4l/O1eabDpZR62VQax+GpMVqtxW2ES3JWwsm8OYOaTChLrSd4cFXV6
62JQSDkqezRlHByvyfN6/zjeVqu/buQm2umIRSLTbkA9eerjIfojQo5H1RWoAhcuCpxIBIpaLMR7
oYW6LlraANm5abpahCf13i9R+KhuzxJ+x68gwMmF7GvLsznbf/FseUcBxdezo7w/SsA+OEI8BRVB
6n8JvtgUxt931L0ktFpoMp039ZE2B8CKUHDep2WEL9Ha1c5X0UYunPPV7u5HOHfKRHs9h00E5Tg=
--00000000000053393d06607fe16b--
