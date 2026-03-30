Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD513C5DAB
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869891; cv=pass; b=B7De2XScB7QgwsyScAU9B2irHRm64oCq+eyvdQwsV42aq6O5iW3LZv6oeZRtpPe75CH+MR7er37z3+YjnIirGxJtWzNCGYZduZUOZ91XIyYmtwEXwJj8/ZHlEroUTCa0upslLVFW99RARUCqaEnKp8xNzrzO7ioVFkXxsx6A98Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869891; c=relaxed/simple;
	bh=VLu2p216AtxEFUOd8o2Lcblw9d9dmfFqB+45rdl3ON4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSwzjgTlv4fnfjVHQ1caQkDlXnOlgANHGNLsZjqG4Cd7mB5UBV5A3Vnt9T6dR+Y/QekBg4WDNVgBMXGKCzavvps5eo4xFNAsAgvk094RO99/fUDoTzLaErBjlcB1Sjdoq7/5uD0yDNGDCKL0eY69JWwrmtYbU2pe788sOgYSfO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3M097AP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzUsou+B; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3M097AP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzUsou+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774869888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
	b=D3M097APtPJANoOu7p7hHIYxhv8HhbUyWKAfJdBsh8lHIA50D+YJMiOCCazYmp5qVl0KFG
	rPACLOyIynPmc6V6fM67gJz1OfHYj6hayFOGpz78jPtH4KM4KZel/YeyzHTuLdQsISP16b
	y612kBpfdG5IO78NmKo2CYAAFUZ41VU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-X4KLgss3PAGLK4VpE7N8xQ-1; Mon, 30 Mar 2026 07:24:47 -0400
X-MC-Unique: X4KLgss3PAGLK4VpE7N8xQ-1
X-Mimecast-MFC-AGG-ID: X4KLgss3PAGLK4VpE7N8xQ_1774869886
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ba0d2e46dso2824541f8f.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 04:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774869886; cv=none;
        d=google.com; s=arc-20240605;
        b=EBShg+7wg6Sz6TgwYP8n1v1Z7Ll47egp54f3Q6XfdkW35elom+tN63NGU7GmuWPWvz
         rM9AwrcVB/rOIPXj09C6+JGr4lft8ddWsTcfDCdDkBriuKttZxuR9HL4evSgUmWl4jwd
         D7WwnCvVvbOo7mMgbr6wxh7Dr42o+DlQhGh84bGuYjOMPw+548vcDUmHAncOB8qwH7Q2
         8Zkh0wHzXWOUqEC7ejjo0snDcm8ctPaq08Y5OTrbONCtZBedtolUJf1ilZM8GVf+tTil
         Uq+9xWvtvztEfpi6ZeyAkSpbwl4jneoUy0bXfsahF2RSDOdJgLL2WvrlZwpBXtb/8Nu6
         rkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
        fh=669fVlIE0unIfAhBh6OHAkyyir73HZI4dpSScKU3/Gw=;
        b=PBn67qnRLKaGkL9MsmZGgKvXH3vVc4kL3hK17CwD0SrRm1asoey5BOoeF9IixnxPrs
         2JLsUg2VOfmvLNiZcYDPEfbedXGWOeZ/qSLjQHAH11vhlCURn4PDnK2GDLxbI8O4qGI9
         RA5CdUF+jiy688tJKQHjTfUmiFSDEc/W8pihMkEtX6hqg6OI7ablV4P75zwb1dEY1ezv
         f30slh4igMeL+nSFmc4eTvt+d/MvFGXsad/hIVnQA89ptyDXtAv7qddp6czIwGzneoB1
         sRVWaHDh2aNrQziHl64uHZ8/OfG3MyLJXeoIL/GHP7wkMMV9fhpKOg/qdB/rb6S8EQiP
         H4bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774869886; x=1775474686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
        b=XzUsou+BOUTpxX7yYDlQTAX4taHhNhW2ESd1xQqVzIc1nMcK6OgUkzOtq11P1i3tQq
         wyUHs/iyjLeIXHTK9VC1C2538u0TBZn6HFcGNYttt/rPezqv8IPjFGKckEXeqf0IREaJ
         PVlKUd/sDtKNHo7gUKNX/dcITpVCE7HKn9sVeV+8GO/6ISra85BusgpPzHq9MmUN4S/I
         cpsVYBQDz+txWGKwW8DBRJFaFkJnUHePdGCHuYL/tpcU8Bz5EQ+gxs1hyeEyn6yW8HbU
         o+X1+ADw58xdGud3tD2Im5Lg+kpVtgXADPQIWtHF2TcHN181Gi2jR+6k83Vz2WKuKK2J
         kOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869886; x=1775474686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wva+hCkG0r8QYM/lNZHYEzgn+YSloTd3OjPA+1CBsBo=;
        b=nMPuosZNpvAJlQRDzRXLRA/YUqPVh4EvlbD1WWPr5PGrSMOSm5VMZ8yWJJiws9n2U3
         xIy5ONf4/mFgK+6eqXkfoxPYncv7RBorPXS+/jt6OX6z2phFR1qBFQ/8YN7Mlv8GY/hl
         9fh3BWU44OkYS4ctYKhoUkAvKUPAthaRnaKtr6eW6qe8BxZN5luNapiXIID3XdqRmlqv
         vOqnKJoA/pVhwTgM8Tb7KBFNbNxc/FfW+v2O9E/KVC1SOSXwFvQFmgTvAcrRcVLXsrmi
         Om9zLdwX7Hny7rxzvX7FhnAkwg6shZRXQ9H+1mpjQizr1LYE4WgYcbIdI35ybl7JSO2R
         YiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0pWltL0xUvSmuWdt7hoYtNiHULQAcPvP0blqAfTNb2MI9aICd7a900AMKuqREbaseVfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2ua/fyhYuFEOLBksJlNyP6PypOYORym6gamOS7IalQlzMxid
	xyrl/awgs3PWZwz9ts8GTqn5E8HE6dlylNeXmRHhuIsOXY7g3VOYgQDf0jmS+dw6uDu8qUtRn25
	veReqwfONbX4sjElkYsqgE6oFoF6VKePZpxG6YGxbLHanS1qyLftR/irTfr2Pg18tXefFLeqDG+
	M5JPGUBwcAXCM97EuqdzQze4MSoHmZ
X-Gm-Gg: ATEYQzwyRjMKaFvpWMIzLb9SYNjArF/QYOEN1Hrq9A6a4J44f322B7bq+CWI0Lsv2d5
	/qSwQKQBfTmb/K1Y254lRV74ROWs30BlcA+YpQaRbbNRkDAbPJqzBYE1JGUHi3S5PgOhqsQATGF
	1c/6R8ZLHfUcSDrpLeVfpQvzUDzqXqTTi4QdFHCuqYTlrGzyGGdyPRu+r4Mo+b3wjAJ4qtvTK1Q
	r5vnKIaQJRS7Qm/vYXnPnUty/pTePWf3/MrheJ6AJ75Mt8py5IbyPGk8eQP1rsLZEI26VHTlTTQ
	CEp1
X-Received: by 2002:a05:6000:25c7:b0:43c:f95c:3e66 with SMTP id ffacd0b85a97d-43cf95c3ecemr9163036f8f.21.1774869885547;
        Mon, 30 Mar 2026 04:24:45 -0700 (PDT)
X-Received: by 2002:a05:6000:25c7:b0:43c:f95c:3e66 with SMTP id
 ffacd0b85a97d-43cf95c3ecemr9162967f8f.21.1774869884851; Mon, 30 Mar 2026
 04:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41> <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41> <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
 <acNwYsm4GfViqiJS@acer-nitro-anv15-41> <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>
 <acfqnRZ4A_aYnm09@acer-nitro-anv15-41>
In-Reply-To: <acfqnRZ4A_aYnm09@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 13:24:32 +0200
X-Gm-Features: AQROBzCZvYZ7bCMWssfj9tfG6zjco3KlWMZnPARkek7xW1MG79EQJ3sUO0VdEhQ
Message-ID: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com
Content-Type: multipart/mixed; boundary="000000000000029cc5064e3c19d9"

--000000000000029cc5064e3c19d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 3:50=E2=80=AFPM shaikh kamaluddin
<shaikhkamal2012@gmail.com> wrote:
> +void __mmu_notifier_oom_enter(struct mm_struct *mm)
> +{
> +       struct mmu_notifier *subscription;
> +       int id;
> +       pr_info("Entering :func:%s\n", __func__);
> +       if (!mm->notifier_subscriptions)
> +               return;
> +
> +       id =3D srcu_read_lock(&srcu);
> +       hlist_for_each_entry_rcu(subscription,
> +                                &mm->notifier_subscriptions->list, hlist=
,
> +                                rcu_read_lock_held(&srcu)) {
> +               if(subscription->ops->oom_enter)
> +                       subscription->ops->oom_enter(subscription, mm);
> +
> +       }
> +       srcu_read_unlock(&srcu, id);
> +       pr_info("Done:%s\n", __func__);

Yeah, calling mmu_notifier_unregister() won't work from within this functio=
n.

One possibility is for the new method to be something like this:

       void (*after_oom_unregister)(struct mmu_notifier *subscription);

So it only has to do

kvm->mn_registered =3D false; /* or xchg, it's the same */
WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
if (kvm->mn_active_invalidate_count)
    kvm->mn_active_invalidate_count =3D 0;
else
    WARN_ON(kvm->mmu_invalidate_in_progress);

or something like that. See the attached sketch, feel free to reuse it
as you see fit.

Paolo

--000000000000029cc5064e3c19d9
Content-Type: text/x-patch; charset="US-ASCII"; name="mm.patch"
Content-Disposition: attachment; filename="mm.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnd3mn5p0>
X-Attachment-Id: f_mnd3mn5p0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMgYi9hcmNoL3g4Ni9rdm0vc3Zt
L25lc3RlZC5jCmluZGV4IDNiNjcwZWU0ZWIyNi4uN2IxNGQ4MDk5Y2MxIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0vc3ZtL25lc3RlZC5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0vbmVzdGVkLmMK
QEAgLTE5NzMsMTIgKzE5NzMsMTUgQEAgc3RhdGljIGdwYV90IHN2bV90cmFuc2xhdGVfbmVzdGVk
X2dwYShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGdwYSwKIAkJCQkgICAgICBzdHJ1Y3Qg
eDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uLAogCQkJCSAgICAgIHU2NCBwdGVfYWNjZXNzKQogewor
CXN0cnVjdCB2Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZjcHUpOwogCXN0cnVjdCBrdm1fbW11ICpt
bXUgPSB2Y3B1LT5hcmNoLm1tdTsKIAogCUJVR19PTighbW11X2lzX25lc3RlZCh2Y3B1KSk7CiAK
LQkvKiBOUFQgd2Fsa3MgYXJlIGFsd2F5cyB1c2VyLXdhbGtzICovCi0JYWNjZXNzIHw9IFBGRVJS
X1VTRVJfTUFTSzsKKwkvKiBOb24tR01FVCB3YWxrcyBhcmUgYWx3YXlzIHVzZXItd2Fsa3MgKi8K
KwlpZiAoIShzdm0tPm5lc3RlZC5jdGwubmVzdGVkX2N0bCAmIFNWTV9ORVNURURfQ1RMX0dNRVRf
RU5BQkxFKSkKKwkJYWNjZXNzIHw9IFBGRVJSX1VTRVJfTUFTSzsKKwogCXJldHVybiBtbXUtPmd2
YV90b19ncGEodmNwdSwgbW11LCBncGEsIGFjY2VzcywgZXhjZXB0aW9uKTsKIH0KIApkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyBiL2FyY2gveDg2L2t2bS92bXgvbmVzdGVk
LmMKaW5kZXggZTRjYjMxNzgwN2FiLi40YTFjMWY1Mjk3YzQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L2t2bS92bXgvbmVzdGVkLmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYwpAQCAtNzQ0
NCw2ICs3NDQ0LDE1IEBAIHN0YXRpYyBncGFfdCB2bXhfdHJhbnNsYXRlX25lc3RlZF9ncGEoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBncGEsCiAJc3RydWN0IGt2bV9tbXUgKm1tdSA9IHZj
cHUtPmFyY2gubW11OwogCiAJQlVHX09OKCFtbXVfaXNfbmVzdGVkKHZjcHUpKTsKKworCS8qCisJ
ICogTUJFQyBkaWZmZXJlbnRpYXRlcyBiYXNlZCBvbiB0aGUgZWZmZWN0aXZlIFUvUyBiaXQgb2YK
KwkgKiB0aGUgZ3Vlc3QgcGFnZSB0YWJsZXM7IG5vdCB0aGUgcHJvY2Vzc29yIENQTC4KKwkgKi8K
KwlhY2Nlc3MgJj0gflBGRVJSX1VTRVJfTUFTSzsKKwlpZiAoKHB0ZV9hY2Nlc3MgJiBBQ0NfVVNF
Ul9NQVNLKSAmJiAoYWNjZXNzICYgUEZFUlJfR1VFU1RfRklOQUxfTUFTSykpCisJCWFjY2VzcyB8
PSBQRkVSUl9VU0VSX01BU0s7CisKIAlyZXR1cm4gbW11LT5ndmFfdG9fZ3BhKHZjcHUsIG1tdSwg
Z3BhLCBhY2Nlc3MsIGV4Y2VwdGlvbik7CiB9CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bW11X25vdGlmaWVyLmggYi9pbmNsdWRlL2xpbnV4L21tdV9ub3RpZmllci5oCmluZGV4IDg0NTBl
MThhODdjMi4uM2M2N2VjMTVjMDljIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tdV9ub3Rp
Zmllci5oCisrKyBiL2luY2x1ZGUvbGludXgvbW11X25vdGlmaWVyLmgKQEAgLTIxMiw2ICsyMTIs
MTQgQEAgc3RydWN0IG1tdV9ub3RpZmllcl9vcHMgewogCSAqLwogCXN0cnVjdCBtbXVfbm90aWZp
ZXIgKigqYWxsb2Nfbm90aWZpZXIpKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKIAl2b2lkICgqZnJl
ZV9ub3RpZmllcikoc3RydWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uKTsKKworCS8qCisJ
ICogQW55IG1tdSBub3RpZmllciB0aGF0IGRlZmluZXMgdGhpcyBpcyBhdXRvbWF0aWNhbGx5IHVu
cmVnaXN0ZXJlZAorCSAqIHdoZW4gaXRzIG1tIGlzIHRoZSBzdWJqZWN0IG9mIGFuIE9PTSBraWxs
LiAgYWZ0ZXJfb29tX3VucmVnaXN0ZXIoKQorCSAqIGlzIGludm9rZWQgYWZ0ZXIgYWxsIG90aGVy
IG91dHN0YW5kaW5nIGNhbGxiYWNrcyBoYXZlIHRlcm1pbmF0ZWQuCisJICovCisJdm9pZCAoKmFm
dGVyX29vbV91bnJlZ2lzdGVyKShzdHJ1Y3QgbW11X25vdGlmaWVyICpzdWJzY3JpcHRpb24sCisJ
CQkJICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiB9OwogCiAvKgpAQCAtMjg3LDYgKzI5NSw3
IEBAIG1tdV9ub3RpZmllcl9nZXQoY29uc3Qgc3RydWN0IG1tdV9ub3RpZmllcl9vcHMgKm9wcywg
c3RydWN0IG1tX3N0cnVjdCAqbW0pCiB9CiB2b2lkIG1tdV9ub3RpZmllcl9wdXQoc3RydWN0IG1t
dV9ub3RpZmllciAqc3Vic2NyaXB0aW9uKTsKIHZvaWQgbW11X25vdGlmaWVyX3N5bmNocm9uaXpl
KHZvaWQpOwordm9pZCBtbXVfbm90aWZpZXJfb29tX2VudGVyKHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
KTsKIAogZXh0ZXJuIGludCBtbXVfbm90aWZpZXJfcmVnaXN0ZXIoc3RydWN0IG1tdV9ub3RpZmll
ciAqc3Vic2NyaXB0aW9uLAogCQkJCSBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CkBAIC02NjEsNiAr
NjcwLDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtbXVfbm90aWZpZXJfc3luY2hyb25pemUodm9p
ZCkKIHsKIH0KIAorc3RhdGljIGlubGluZSB2b2lkIG1tdV9ub3RpZmllcl9vb21fZW50ZXIoc3Ry
dWN0IG1tX3N0cnVjdCAqbW0pCit7Cit9CisKICNlbmRpZiAvKiBDT05GSUdfTU1VX05PVElGSUVS
ICovCiAKICNlbmRpZiAvKiBfTElOVVhfTU1VX05PVElGSUVSX0ggKi8KZGlmZiAtLWdpdCBhL21t
L21tdV9ub3RpZmllci5jIGIvbW0vbW11X25vdGlmaWVyLmMKaW5kZXggYTZjZGYzNjc0YmRjLi5k
ZWJhMDU2NDY4YjEgMTAwNjQ0Ci0tLSBhL21tL21tdV9ub3RpZmllci5jCisrKyBiL21tL21tdV9u
b3RpZmllci5jCkBAIC04MzUsNiArODM1LDU2IEBAIHZvaWQgbW11X25vdGlmaWVyX3VucmVnaXN0
ZXIoc3RydWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uLAogfQogRVhQT1JUX1NZTUJPTF9H
UEwobW11X25vdGlmaWVyX3VucmVnaXN0ZXIpOwogCit2b2lkIG1tdV9ub3RpZmllcl9vb21fZW50
ZXIoc3RydWN0IG1tX3N0cnVjdCAqbW0pCit7CisJc3RydWN0IG1tdV9ub3RpZmllcl9zdWJzY3Jp
cHRpb25zICpzdWJzY3JpcHRpb25zID0gbW0tPm5vdGlmaWVyX3N1YnNjcmlwdGlvbnM7CisJc3Ry
dWN0IG1tdV9ub3RpZmllciAqc3Vic2NyaXB0aW9uOworCXN0cnVjdCBobGlzdF9ub2RlICp0bXA7
CisJSExJU1RfSEVBRChvb21fbGlzdCk7CisJaW50IGlkOworCisJaWQgPSBzcmN1X3JlYWRfbG9j
aygmc3JjdSk7CisKKwkvKgorCSAqIFByZXZlbnQgZnVydGhlciBjYWxscyB0byB0aGUgTU1VIG5v
dGlmaWVyLCBleGNlcHQgZm9yCisJICogcmVsZWFzZSBhbmQgYWZ0ZXJfb29tX3VucmVnaXN0ZXIu
CisJICovCisJc3Bpbl9sb2NrKCZzdWJzY3JpcHRpb25zLT5sb2NrKTsKKwlobGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKHN1YnNjcmlwdGlvbiwgdG1wLCAmc3Vic2NyaXB0aW9ucy0+bGlzdCwgaGxp
c3QpIHsKKwkJaWYgKCFzdWJzY3JpcHRpb24tPm9wcy0+YWZ0ZXJfb29tX3VucmVnaXN0ZXIpCisJ
CQljb250aW51ZTsKKworCQkvKgorCQkgKiBhZnRlcl9vb21fdW5yZWdpc3RlciBhbmQgYWxsb2Nf
bm90aWZpZXIgYXJlIGluY29tcGF0aWJsZSwKKwkJICogYmVjYXVzZSB0aGVyZSBjb3VsZCBiZSBv
dGhlciByZWZlcmVuY2VzIHRvIGFsbG9jYXRlZAorCQkgKiBub3RpZmllcnMuCisJCSAqLworCQlp
ZiAoV0FSTl9PTihzdWJzY3JpcHRpb24tPm9wcy0+YWxsb2Nfbm90aWZpZXIpKQorCQkJY29udGlu
dWU7CisKKwkJaGxpc3RfZGVsX2luaXRfcmN1KCZzdWJzY3JpcHRpb24tPmhsaXN0KTsKKwkJaGxp
c3RfYWRkX2hlYWQoJnN1YnNjcmlwdGlvbi0+aGxpc3QsICZvb21fbGlzdCk7CisJfQorCXNwaW5f
dW5sb2NrKCZzdWJzY3JpcHRpb25zLT5sb2NrKTsKKworCWhsaXN0X2Zvcl9lYWNoX2VudHJ5KHN1
YnNjcmlwdGlvbiwgJm9vbV9saXN0LCBobGlzdCkKKwkJaWYgKHN1YnNjcmlwdGlvbi0+b3BzLT5y
ZWxlYXNlKQorCQkJc3Vic2NyaXB0aW9uLT5vcHMtPnJlbGVhc2Uoc3Vic2NyaXB0aW9uLCBtbSk7
CisJc3JjdV9yZWFkX3VubG9jaygmc3JjdSwgaWQpOworCisJaWYgKGhsaXN0X2VtcHR5KCZvb21f
bGlzdCkpCisJCXJldHVybjsKKworCXN5bmNocm9uaXplX3NyY3UoJnNyY3UpOworCisJaGxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShzdWJzY3JpcHRpb24sIHRtcCwgJm9vbV9saXN0LCBobGlzdCkg
eworCQlzdWJzY3JpcHRpb24tPm9wcy0+YWZ0ZXJfb29tX3VucmVnaXN0ZXIoc3Vic2NyaXB0aW9u
LCBtbSk7CisKKwkJQlVHX09OKGF0b21pY19yZWFkKCZtbS0+bW1fY291bnQpIDw9IDApOworCQlt
bWRyb3AobW0pOworCX0KK30KKwogc3RhdGljIHZvaWQgbW11X25vdGlmaWVyX2ZyZWVfcmN1KHN0
cnVjdCByY3VfaGVhZCAqcmN1KQogewogCXN0cnVjdCBtbXVfbm90aWZpZXIgKnN1YnNjcmlwdGlv
biA9Cg==
--000000000000029cc5064e3c19d9--

