Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB53939B5
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060874; cv=pass; b=tlXeXQfY8sDvEp+Y5xDKnYa8NYq3v/EJmOs5UMFuvrk9ib3X7lBiURPMxPUuyEUXxB6nESXCQIM0lxtavAFFd0O38s6CDvGZ6cf6F51Ybah+Tvc2dCi0DkcbyNEhz8fUfTEtGJ9TOAkelI1w8OnXcmjyUBLlGLwI+QAvJIBqzGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060874; c=relaxed/simple;
	bh=2Ow8bkx3gpfyhSLUKWiSKNyCLx19AuMfizaujCtg4Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9E7pbdVh5hwJ32jdR+BNTA4dIa83Z8X/5G/8/DPLxVv2wIEwynocYDQN9RoNN36s4GRX7zen1UsNIzuCnARZuVMNr7gYGmuR0QJpq7BJePcoFp2d55Bd64DhaorWNjAnSR9LpgP8m9puHyptRLzOxyPOSmps5mNp/jN3fJj/aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbRpBP3T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIcytGar; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbRpBP3T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIcytGar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775060872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ow8bkx3gpfyhSLUKWiSKNyCLx19AuMfizaujCtg4Cc=;
	b=RbRpBP3TJuoAt1NRirW6asicRzA8dj1K9jwLT0PKxu9vRL2ZgQHg7+l+P776eQA4/7QQHa
	LE1LWr+0Raz7+NWnW5lyLgTS3MpjvlgF0HplHmfSzCb6dbCQtlJ02aaX1oRlX0Sc8P6e58
	iX3ZDU6ax+JcqcmkBjoR87UXL4SKdlc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-5BLsV6vVOQ-QyiLOEBcaFA-1; Wed, 01 Apr 2026 12:27:49 -0400
X-MC-Unique: 5BLsV6vVOQ-QyiLOEBcaFA-1
X-Mimecast-MFC-AGG-ID: 5BLsV6vVOQ-QyiLOEBcaFA_1775060868
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d00dd913cso3623543f8f.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060868; cv=none;
        d=google.com; s=arc-20240605;
        b=OW0OFAvlyrJM+P8a63UvnY8iqi+uhg0owol6XqlvPGnW+r8lVwPEVm2ONXpgdkQGZe
         6JKOyS6s3etVHG7xDvqsFQSPqt2/5rbJQJgBQCyXsrksfaIA63wHVIOa3KHw0DecMf9f
         pKm8IGzYtFsENNqD0lMXL8F6TABR5I0yEd5NVGxUodoCiozHPrLSbaugsrO/9+OJ4E4O
         9MW+GnTCwolieXzRICduBtWMe4E6nnQK5KJJuz1YUDZPYgDRv4VmyqW/VI0wTZqLnO+w
         0WRCXk+lgwTn/TQzay3LLIntU4mtagWQjNTSeuaICeeP2v4nbD3b0EcbgCrrkK4/Z5So
         tLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Ow8bkx3gpfyhSLUKWiSKNyCLx19AuMfizaujCtg4Cc=;
        fh=HErIJxKP93aBSdPTQbD0Zlqtdn/EClUfaxzvWFMOCOc=;
        b=YcBK1zGIqk2mbVTNEPaJTjQgWU2RMt9GUtwagPQLiiZlYnemTjd43KhVsdOZcZNfjW
         0LZEAaAkDA6RYZJXlW1X0N0qbTEDaVf2ANGkoyuHRyPsDCMQhjKfwhPJQnc5uliKHKVX
         Khru/Gn0HPieC5yYOHkwMNH1Kk6MFHFLINO164yfbSPTyiiUJJ5hCVsA+b5fwbHL3Uoa
         r+SvgDeXNmnmVKTOrnCVNy2NJ/9i89k3ebX7na/ZxQ+4iicB4v5LwjNDzodAZ5S/w/Ec
         CHxm/dN1y7MBxa6AvdE1hsKHW0Z8PG7ag4gHURUJRktex/A3BhgPF6OsRiMUqeatJ4Z1
         6g3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775060868; x=1775665668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ow8bkx3gpfyhSLUKWiSKNyCLx19AuMfizaujCtg4Cc=;
        b=bIcytGarLswWTMEdDCKO9CriwyBWoa1DOqy0MIeghgb6ELEm6A1S6+H7DjF2Znv8Gr
         xj2TJ4h7O0CgO7aqxqFzsCptbymN4UpVSuxEJA16gqT1E64bYBbZqULLu7SVctCyI7nu
         sL4I/B3XYl1WmPQlibR6AIkD3ojGAGPLBaLKRg6cTT0ASWNksy4tSB0ShFjnEqPt2ej3
         90bBPiIWtucmLXYuFCkZSQhbXCTsVefprQqPFlXdmsey+W8jcd85r4ZskkWzW0/+nPJ8
         r0ydxo+0QIhgR0RYcZ/6SVBVx7Yh9dI8RJZCk2KaZhDmQpdQ9pYSipoRpatd/i1GNDFj
         XYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060868; x=1775665668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ow8bkx3gpfyhSLUKWiSKNyCLx19AuMfizaujCtg4Cc=;
        b=dg8XcLheAboXM6Zmbj/bXssw2KbM9nY89EkJxES8mno57mkC6Ud6adLqj2ZDAtTpUU
         uoqhzAD7A+qnaQ78G/PRUe+RtTmwxEstrQ/L0q6pyxjZZY2jhtJ2bYnufYfEHEaSLv5W
         sBhJt/Jw8CURmZceA9yWzlCsBi0243LaSzXuW6Q53Z2Ux0+DspNib236x9snmSUvnzh4
         Np49QpEwL23oj9T5vdHMvNQ4AjXvLqkv/ZLReIXknQqO7mNP9vYe1zVADXR4GDxmEaGt
         Y+u6qA3KT6J8c9c8oA8LjjvXP9VdK3h57oWNHHnfhsH/Cb3A3DS6LpNQ+XbanS86ioP6
         t0rA==
X-Forwarded-Encrypted: i=1; AJvYcCX19JUcRidFtX6OTVEMNGlUdeotYaPQ0IjQ/MRAujbRvUFtPHRsM35cRU8VUnPGQa3CP6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJya/9l7oJA6rJQHl8+cTFMf2W3lM4j3lPFX/QZJPfy2Z25Ff7
	p3oi3lUvia1et/jT/Y1r5YCAHKFoAPhTCcGQN01alX8GqSkcQL/N5uBxqVGsRg0Ow0lKOGTkQMV
	TCSaYa7LQutTgqcGtiZ7A6lcr0Vw8hniDrDQ8PLXzuyBJzvvkq/DYZ/3JwZzcL3nYXJffsexKFA
	acX2XdsGZhnu6zsJH9ppGlhSN4uCPm
X-Gm-Gg: ATEYQzz+jm3AFZTXAn5ZDs8rmpfpbTYxsXe0Vb6SOrEXMd0jPI3VV21wRJMv4FDOECu
	ZTdH50fN5cNIX0QhMD6Z1rWMfLBAqvmGYcrWpqwZDmbAipVIn/hTgy70Ev+S7s1OclVwG8dlRhx
	F8LFr6j5wg7yd+r1ptxQcRcY/XPQoxGw/grknMvxYiU/7kDdONFyqrGhgb5758D3vAe/y2uokOR
	oZqHFBRq8XskNQ4Th8Zg1gp3eOW7uliodZyd1vp5niLyTnvfh/ZSPGj3sawBB6QC/CaR1Ltx6Za
	W6vz
X-Received: by 2002:a05:6000:310a:b0:439:f64b:a82b with SMTP id ffacd0b85a97d-43d1504a6c4mr8118731f8f.6.1775060868241;
        Wed, 01 Apr 2026 09:27:48 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:439:f64b:a82b with SMTP id
 ffacd0b85a97d-43d1504a6c4mr8118682f8f.6.1775060867771; Wed, 01 Apr 2026
 09:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326181723.218115-1-pbonzini@redhat.com> <BD696E74-1EFB-4E70-9DC8-756A7810599C@nutanix.com>
 <CABgObfYhNJhvVhe1nRG11MMF9p=eT-QoaGNGaN8P+YaywNUg+w@mail.gmail.com> <AD9FE419-97DF-4399-B4C0-C172A2700530@nutanix.com>
In-Reply-To: <AD9FE419-97DF-4399-B4C0-C172A2700530@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Apr 2026 18:27:36 +0200
X-Gm-Features: AQROBzBGA9y8J6rxz77QcqGW1pZgSQRSn2Yp7ClbcObouaMSQ6-A12iuJjx0S2E
Message-ID: <CABgObfatgb-XNcPuYR=+rrzj7BXxEhnn19CU5ZFNUPeJhNqX4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
To: Jon Kohler <jon@nutanix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	"amit.shah@amd.com" <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:59=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
> > Great, thanks! FWIW I found a small hole (just by code inspection);
> > translate_nested_gpa is always setting PFERR_USER_MASK and therefore
> > always using XU (and always allowing execution for GMET). The fix is
> > not hard, basically translate_nested_gpa needs to become an entry in
> > the nested_ops and the callers need a little bit of adjustment to pass
> > more info down. Then the vendor code can do respectively:
>
> Ok cool, will look forward to that!

And a few more from Sashiko...

1) do not clear blindly ACC_USER_EXEC_MASK for NX huge pages in
make_spte(), because NX huge page mitigation can actually run on AMD
machines as well.

2) add a comment about fast_page_fault happening only with XS=3D=3DXU, at
least for now

3) include the XU bit in __is_bad_mt_xwr(), evaluating bad_mt_xwr for
(XS|XU, W, R)

4) only enable nested MBEC if enable_mbec=3D=3Dtrue, likewise only set
X86_FEATURE_GMET in svm_set_cpu_caps if gmet_enabled=3D=3Dtrue

5) check CPL !=3D 3 instead of CPL =3D=3D 0 to recover PFERR_USER_MASK for =
GMET

6) change shadow_acc_track_mask in "KVM: VMX: enable use of MBEC", not
"KVM: x86/mmu: split XS/XU bits for EPT" (for consistency with
shadow_xu_mask).

7) clear SVM_NESTED_CTL_GMET_ENABLE in
__nested_copy_vmcb_control_to_cache, not __nested_vmcb_check_controls
(i.e. sanitize the destination of the copy)

Overall a pretty solid analysis from our new overlord. Roughly 50%
false positives, but I accept that given the high quality of the other
50%. Also, a couple false positives are worth adding comments about;
it may not shut up the AI (#1 was explicitly called out as "cannot
happen" by an incorrect comment that I added...) but it can be useful
for humans anyway.

That said, it uses a damn *lot* of tokens to do this kind of analysis.

Paolo

