Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442402;
	b=4lph/pqkNtjnVFml9pVviA9fvX9ZajszYPPQ5Lx3xMu9K4Bau/zHyXU7h40s7m52ceo7
	 NcPzPZwP7PQ6yDyPTdluYANinBqNCT82cuUtHVJ9IX3u/IjBpRxJDkHDHtRJw5RLqUbNY
	 zrAWLOv3jHGlCasFkslDK/fTlxvaxj4ofBQF0OGZ+FCEM+iErXe/Hi374Z/yJ5zNxQQwN
	 M7COMN0W4C9qkQwwh0a4RLjLDbTmtrJBYOKNDaXzLCIueMArldgt2WzJSWrULNTreeVp2
	 WgYX1QbLJznHzqvEznrQS1qGzGxWG0OYbNNt9nQZPzR2B3UIysmoc8Bj6iZWipCYsVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x6GQlR97tIMyvsNz+qk5iDCNekyRuVayoebvkV1BUAA=;
	b=uKZ8SsQZUObir3+Yz1+Slrqx6ZlS5ZNt0vgFvgfn/uKU0YcPV16f5k7I35KP22GUdqa4
	 ZCKDk6DusIugIgdVmnAU2wR4iyeyEyx6WLO4t9G0Z7lPzgjVsiBKxpYpaIZNJBbhO1xVT
	 ONi/SGiju5ntcU84JRSSUD+/n4JC0a+L8f8BgW4xjcoufPIyn4Y+HcZwqRvy4rrhk6Ss2
	 fHdXoAaK3GJMZ6A04+ZnR+G5At8OknJYHHGJtHKM3Ve+kI+NHDOm4QwPHEnFVTZgvGnT/
	 y5ak+Jfpd3Pvnd6essfAgfD/cBym+Uyl4gAOISFjhi+CeZ9aw78fEMBCjlM4Wmt0f4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="iH/wd37L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B68606A326
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B68606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iH/wd37L
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2605a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442400; cv=none;
        d=google.com; s=arc-20260327;
        b=FKJNS1FA8hreUnENyg17NgShoUz69NVHasnZj4MOdLfSInGqvIh+hDwIifHFW727e4
         XnP+wheuZ8/aZKhskjHUbDlNU3QdKBd6nHwDWZV2ZuZ/T9qJmgQ93Ceg0FNXHKmo4sym
         ZJvgaGXPGB0Vp+yaFtHEnctV6geZAVQPmtSHdpGfRJEPG5wVGdKP9xAw1irCyJznaYz9
         NIuJdqmRLj9tL6C0acS4pj0QofZ8Se319+YiFNy0rIw7H+dVLLMePZt176/RYijpgvX1
         yRTJHTxSjxZg/emPAp7VKtbK14qBvOJEzpSs0BiBjsItpKNsES6Xqb/zZl2w7CErSBpG
         WmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x6GQlR97tIMyvsNz+qk5iDCNekyRuVayoebvkV1BUAA=;
        fh=n+T7JFG246dIBFAkioO/ooGuV7OMs4RK0i9AZiaJPIA=;
        b=bgI4e3H3YXY2qqIULohrxBiHCS8Dfbxmd5d6TGioatf7h5YC/7qarFWNSa3A/6tFpP
         LjDaXJgJmYxu2WTHapN0sP2VZMzDN/dJPq8S1uD5cfCJ7KiaMgrTzUILwGh974EHE3MM
         4bdxC60uH5Ljq+H1ojLQFY6Z8cBVTscevax8uaJWyydQoF5qFkOzgCYrYD4TDQYyTfFQ
         OW6nRGsLmkwL8KDsp1b1BjWBiA2qTkK+HK82uX2ESs6UkleWbA2wD7aouWc1Rnj4/Okz
         fzm3g00uOYwZeB8hxInAB85niW0cUdmC2Rc61HS+KC0PXh/88Q2a3SfwVaU+jAZnbLDi
         pgow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442400; x=1795047200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6GQlR97tIMyvsNz+qk5iDCNekyRuVayoebvkV1BUAA=;
        b=iH/wd37LOg2hD3TTD1m4q0qaLfhoXoQUtQjEilEqBxnKJxbifvZHG67+MeME0M8WGu
         Ux8INvsQJMiPw/PdFkvNsGCSdtaFu6NBxDAsk1VA6RyZR1qKKE4Ckl/UH6Rig7phjNE9
         WklDOtODfrt37ymWxn1AQUGJUokgTSG1AgdjMwN1gkaesF4YiZ1DgZnnrUJr+yqaPWAT
         UUtWdqd0zZJpy8uuQOIaki113+rawIwWPmfRJmt0rGg8wPGEBlnazc8MLfvWbf9d4Z3L
         zt0wT6rl8FNYicdd1gO8Al8EClUL06yC17IuiUHAhAeEQ1K6vFZhcjqE0SueEd0Jut4F
         XEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442400; x=1795047200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6GQlR97tIMyvsNz+qk5iDCNekyRuVayoebvkV1BUAA=;
        b=WpVmFwn9s0EQ4G9kGAtVrboYIdRZ3nKTUPzwWXcVda2pLUcWSD98AAubWE4bwBzK8w
         buvBjb0VoqeSdoLfmKr7LuUHyBuPPkuRef1BpMh98pVtDFZtPLFmoGPxiacv5LIaVoil
         AnHQ3uVRgqG08ZK71m8/pYGCbUOBPLFSIpIOHbQPDBaprSVtdUq/l/QZGlOLwXIgvxto
         9lblwrvlNC3/4Pm9iijA1f9E/RLIMwAEQ+jQk8d1BA1/l2W0fOeB7z1xVF4bod2dnOo8
         3iDNaOEgYzon8zTmxzn4yCLGRb1AbM/hIcEb9uVXw4FQgxRsaZp3ptuePoHOV+mkfy9W
         a7sA==
X-Forwarded-Encrypted: i=1; AL+hErF14VRanLiCnWJL2C+S8KbM869rofO+zc1J1zBHRPIsZlty4ahoJai5YvIOxM4+hnbbRC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v/1kOUvIcOiUTNDPzEFGAbRH9rNhQQX7Fhfi9SeYLmjVHkIeI
	3VWoBOYq+ucJwaW90tZ71MT/m42cAQ6CBDGbOCmGF1XgHuKBIv3JI3vBMlU779U3RfAOozvqlpv
	1Aasd+1xWAq+YWzY8n0rbgVEjA0eq8zHbTLoHzx8Y
X-Gm-Gg: AYBFou0VBt6KiVBdwaDl0V4gcXWanIonxp/M+QAU+vVcbIgEHxsdJVkl+t6iJATAVZd
	ZzRL7CKoaX+z36yF1kl4CO6zBlnxJNaqydUGrJC3gvKFPRE5b9PyBBSjSSiT1gzkBbTMXA6NooZ
	+S5bgMk1OvADV3D78xz0goGYwkoWhvmrz26omFiTJONvgUlV82jJAduwFAV5LGaUo2ty8/n1z3q
	gOsZH7uE+5nFavdfkJeYiJ+aB7+s4zyN1K2s+ISfVGLVEK8coUQLwrivdcFrC+Vp9n2rwX5Zt98
	0p9uVXT6pSiztLRFtKPRtG+5Hp5xvlmdPMhmOq6Lmiox0RQmOUvarBI7FO1edqZ8edMzx28BI/c
	AnVbHol1opXtqKYRy/1uT6Zz1ZRjJ2YqWySSfTU/SFuLt5PAMNWGbGafZHssJR1oTid5SWp0n
X-Received: by 2002:aa7:d1d7:0:b0:6b5:77a4:e7c9 with SMTP id
 4fb4d7f45d1cf-6b79f51181fmr33260a12.2.1794442399569; Wed, 11 Nov 2026
 16:13:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <e08e3b6d0a8dcd25f1ee3e97a64acc1cbd3c0f1d.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <e08e3b6d0a8dcd25f1ee3e97a64acc1cbd3c0f1d.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:13:07 -0800
X-Gm-Features: AclHuK8odVhxcsphtnxehMA2gTchgOO8TDhX7Llo8FUPPxJ2xf2wIKtREyW4NxM
Message-ID: <CALMp9eQ5CAZ5GASL80qQBB-86nKskdiadFinbw+6g0=9ycYXGw@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] KVM: x86/pmu: Honor enable_vmware_backdoor for
 VMware pseudo-PMCs
To: Zack Rusin <zack.rusin@broadcom.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:08=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Check enable_vmware_backdoor before kvm_pmu_rdpmc() hands an RDPMC of a
> VMware pseudo-PMC to the VMware emulation.
>
> The pseudo-PMCs are part of the VMware backdoor, but only the
> emulator's check for RDPMC at CPL3 with CR4.PCE clear honors
> enable_vmware_backdoor.  An RDPMC that KVM intercepts at CPL0, or at
> CPL3 with CR4.PCE set, returns the host TSC or time to any guest, even
> with the backdoor disabled.  Inject #GP instead, as for any other
> invalid PMC index.
>
> Fixes: 2d7921c499af ("KVM: x86: Add support for VMware backdoor Pseudo-PM=
Cs")
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
 Reviewed-by: Jim Mattson <jmattson@google.com>
