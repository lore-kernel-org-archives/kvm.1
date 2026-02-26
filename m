Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B733439D
	for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150166; cv=none; b=PAsUwha+T6g8p3KnmTzmmNY0IpMkz4zQ1MnhB9pmPmUJwO2EkANTchdARLgNp/Ezf1vpu0J3PHT+OJ7mIrU+KIxq2sT7jlmHJMzLQctNcUHrzAqK3r32R/P/RA5jsnw1LYhLrr8dEoNbUmedns8nxuWod/PrPRrUsgFnG5eR24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150166; c=relaxed/simple;
	bh=dO5j/8P0CGpy9elIlT4S456OEShdLdz1gkyhZcO5kTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gwHBLDpNy5MpoTw1yaUS08odmYemUkMWOI+Bm7A2XC2IJHyr7HgFb87QbAaPLnafRudeNfXr/u+n0KVUh93qnAoyO7Y9divqMRP+RVvCqDhQf9tNJ1Fv5XqtkcqGCYa7ePr+/uiSyqFwFgqxMnD9Ox2nkZLAoQMk0ejkZ0rHzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XgYuY16; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XgYuY16"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso1401100a91.0
        for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 15:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772150165; x=1772754965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kZCSGy2Zm1RN5RRM4KyVYeQq5QPnXjbgoTlqEo7MGA=;
        b=2XgYuY16ZlAw5mXD4/PNOYMYuoLIk17aYXkY/zKG59kcjMER6McvDs0OZDWeNxJjyy
         Ky4fs05XpRojUYGL/0007FuY6tfNMbeoeSCManWHmpzK9svUTBV6KmPLyqPerqPHLUkS
         Ao4HezkBEK4WmZw1vVRD8Aa2MMyX3DgLQ/4L2jBVyeqxw3IExapNeH/AWCFZFN+Eko8K
         wpq4JxmvEvhaqAS91TDgcWteuMoAvnw3EdWqRahjhSDJ7JyU+hiiprCZYiQfp4aNq4AI
         5qhqg1r/MKFhm5x3LtuhQ/CkCVBFiDaOgYtzTadx6IcLWjtBEXltnmbC8TjHnk3PRAqt
         npHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772150165; x=1772754965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6kZCSGy2Zm1RN5RRM4KyVYeQq5QPnXjbgoTlqEo7MGA=;
        b=UkUNWr7Act2z1DiyhtPxktqFoh+OJKjnXlxGj2fttpeFcw6FXoeUw4F1nGqdf81xd8
         rou7VyBBbdAEWTUps7SS/nOUqx2TldU8QLoLepHIlnlSFJuc7bLxcWeaYVdKG9QCeun3
         phqYY+ejo27muMZ3qxohkvHyGP06gOlG1+QV18HKQlCRIkZv6a9CzrpD3R/OB9F/54BV
         Vx2JMDnrk3v2QlJar1tmFSopYWKbbO03piDnTlxzg1/uQeojZ3dfsq/N+IGYPIXpzYAv
         kQEImgkOBRaMg6HfnPmM2+3c4ZLgMoPmv2dM2RFWbbykKe8KkAlJCOm9Spm2G8iC9BdQ
         SOfA==
X-Gm-Message-State: AOJu0YyPnuEh1vNsYyyjx+e/WxwAgVL2CTGnJjOkoNOH1mC+TVd8B2ht
	pvfcExhyHpm6bW7PnjqnFZlmKpSLNwrWGh2uSiSPC1wLxB78+IAyFFAERcUmx2f5nPel8GVAss0
	ThuJP1Q==
X-Received: from pjbnd5.prod.google.com ([2002:a17:90b:4cc5:b0:358:f532:89b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d46:b0:343:684c:f8ad
 with SMTP id 98e67ed59e1d1-35965c3871dmr765837a91.4.1772150164478; Thu, 26
 Feb 2026 15:56:04 -0800 (PST)
Date: Thu, 26 Feb 2026 15:56:03 -0800
In-Reply-To: <20260120201013.3931334-9-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120201013.3931334-3-clopez@suse.de> <20260120201013.3931334-9-clopez@suse.de>
Message-ID: <aaDdk4FabBPOD84P@google.com>
Subject: Re: [PATCH v2 6/6] KVM: SEV: use scoped mutex guard in sev_asid_new()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pankaj.gupta@amd.com, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026, Carlos L=C3=B3pez wrote:
> Simplify the lock management in sev_asid_new() by using a mutex guard,
> automatically releasing the mutex when following the goto.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/svm/sev.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index d3fa0963465d..d8d5c3a703f9 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -231,24 +231,20 @@ static int sev_asid_new(struct kvm_sev_info *sev, u=
nsigned long vm_type)
>  		return ret;
>  	}
> =20
> -	mutex_lock(&sev_bitmap_lock);
> -
> +	scoped_guard(mutex, &sev_bitmap_lock) {
>  again:
> -	asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
> -	if (asid > max_asid) {
> -		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
> -			retry =3D false;
> -			goto again;
> +		asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
> +		if (asid > max_asid) {
> +			if (retry && __sev_recycle_asids(min_asid, max_asid)) {
> +				retry =3D false;
> +				goto again;
> +			}
> +			ret =3D -EBUSY;
> +			goto e_uncharge;
>  		}
> -		mutex_unlock(&sev_bitmap_lock);
> -		ret =3D -EBUSY;
> -		goto e_uncharge;
> +		__set_bit(asid, sev_asid_bitmap);
>  	}

I think I'd prefer to throw this into a helper to avoid the goto within the
scoped guard.  FWIW, I also tried (quite hard) to replace the goto with a l=
oop,
and couldn't come up with anything better.

No need for you to send a v3, I'll incorporate these patches into a larger =
series
(there are some locking goofs that need to be fixed, and at least one of th=
ese
patches will generate an annoying-but-easy-to-resolve conflict).

Thanks!

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index af84357dc954..249384e30320 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -198,6 +198,28 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *=
sev)
        misc_cg_uncharge(type, sev->misc_cg, 1);
 }
=20
+static unsigned int sev_alloc_asid(unsigned int min_asid, unsigned int max=
_asid)
+{
+       unsigned int asid;
+       bool retry =3D true;
+
+       guard(mutex)(&sev_bitmap_lock);
+
+again:
+       asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid=
);
+       if (asid > max_asid) {
+               if (retry && __sev_recycle_asids(min_asid, max_asid)) {
+                       retry =3D false;
+                       goto again;
+               }
+
+               return asid;
+       }
+
+       __set_bit(asid, sev_asid_bitmap);
+       return asid;
+}
+
 static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 {
        /*
@@ -205,7 +227,6 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsig=
ned long vm_type)
         * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
         */
        unsigned int min_asid, max_asid, asid;
-       bool retry =3D true;
        int ret;
=20
        if (vm_type =3D=3D KVM_X86_SNP_VM) {
@@ -238,24 +259,12 @@ static int sev_asid_new(struct kvm_sev_info *sev, uns=
igned long vm_type)
                return ret;
        }
=20
-       mutex_lock(&sev_bitmap_lock);
-
-again:
-       asid =3D find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid=
);
+       asid =3D sev_alloc_asid(min_asid, max_asid);
        if (asid > max_asid) {
-               if (retry && __sev_recycle_asids(min_asid, max_asid)) {
-                       retry =3D false;
-                       goto again;
-               }
-               mutex_unlock(&sev_bitmap_lock);
                ret =3D -EBUSY;
                goto e_uncharge;
        }
=20
-       __set_bit(asid, sev_asid_bitmap);
-
-       mutex_unlock(&sev_bitmap_lock);
-
        sev->asid =3D asid;
        return 0;
 e_uncharge:
