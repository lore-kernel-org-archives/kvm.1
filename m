Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704863CF699
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747980; cv=pass; b=biflaqZbk1PQ4HUIIhRhe33bStJnjEdhWYRehtx2jN6gQC6ii8nSbOqimDw39lB14FIpOd71E9/qGVJLyI7mEscNecaYKv0AclEEa5dVbqmNKVDwVj1hu3zIwI+bTorD4MtQxk2UUvUYfGgF7pwfdBox0gRxXeQCtPyZkx8h02o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747980; c=relaxed/simple;
	bh=kJuSzV/a9VZgvsyiqbs9gRWnFA23MYPxesTOVgY4440=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvAKTVGgfT2NXLGvGwrqfgm3O9HI732bB4KWjao5jiC5tUNuJeMThq+UMPm/H2xc9tntGjketJL1njLaMd37PC94k/b+FmzCciZjotD/4Gux7GFhPGHPLJ46Qn/3EZCkANnUX7eVYnB7rTGfvBUnDqYUAYVu1XsT4PusWbijw2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBr3G1wu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9vo81yK; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBr3G1wu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9vo81yK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775747978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJuSzV/a9VZgvsyiqbs9gRWnFA23MYPxesTOVgY4440=;
	b=WBr3G1wuhRSFJNjsa1IBFeMdeBGTSsXTJe7QsdDOf8Qs8zNSblAP2bGw905cNMvELBmzcH
	Zd7olJpQqIyQapcxF6NsdX8n+pkNsPCLJz9lnzojfPzXrr+LmkSGWY9zcF60sy4Q2PamPk
	BT/k7bS5EU1XKMJEesjSZOJUvDWoio4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-wnx6OtOXNL21NpLGP5DRAQ-1; Thu, 09 Apr 2026 11:19:37 -0400
X-MC-Unique: wnx6OtOXNL21NpLGP5DRAQ-1
X-Mimecast-MFC-AGG-ID: wnx6OtOXNL21NpLGP5DRAQ_1775747976
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so12834975ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 08:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775747976; cv=none;
        d=google.com; s=arc-20240605;
        b=HLEYlMk81BUZHJrCODnOv1RPUvZENtIv7rht2CIGj5T/mdd8WXeGTpS6zFrShKXqYC
         BfQcP+XLIYh22GaPkphr1ra5qtfUw31wf7Rd6MyIMB/uVGAmimndtwS5RAXC5qoexmU1
         9fCYrII/vE6Mji3/FjfvPVLm1+yI61Gy1CysttCC6q/8jcKgc0KSGD7q01+IGDhyVvVO
         OMsiJVqoDiw2bKWi8dUffWB6sGkZocq3k8yMLG33mCk46FmjuAPJxCdJe2Jjn/c7MyOj
         McEdJz6Vzg7e07yY+RHYYsi7VrM+aoKNrCe7Pbvy7d5QXnvkRnPjnrGNMfZ93mnIchok
         vZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJuSzV/a9VZgvsyiqbs9gRWnFA23MYPxesTOVgY4440=;
        fh=s1elN1Klp7j5Gv9CMcQC6qSeIpJWh37LxLcnWtOqDtg=;
        b=k/0gt+VKGcOCoCH77eZ9r+4qDrBTVfd/a4qmafwHDOdKEjH5vEiRRgJRYK/MUME7rl
         Y4RiTyxrZBfPpZqNJQEcDX8xo9xpKkmoBAVTalSK3eHe2/Zj4BC7Sg37iG76U4o6uCAq
         tGggb9vEzx7ai9hng6zIUu6XqdF9jz960+kgEKwsEePwSqTNNK3zwQ73Ljmj34tCH7es
         1ysbFzpGRw0JrnBnqZ7HypA4C3DFnZitqBvA8/f5YQ+G4vNlKIwE+eTzebGyI/FC1zSw
         SoS49BWGo0YUck317Z7CIOeWWk3lf3vFCqNQOcr6P/LKHln1/xghFjN1AvnW1/+mQRl7
         jDPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775747976; x=1776352776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJuSzV/a9VZgvsyiqbs9gRWnFA23MYPxesTOVgY4440=;
        b=I9vo81yKWhgBPAAxzGni408HqbumjQ1retb4TH0MBoZtpfj+YpbvC9V5YHv0ciCNHd
         jjeb1ch9DvpxrRcpfMd7AX6O6tJlXyTBiiN2jRdD2UttMppPfMw0UUIzJnt08NUlVIhL
         iIrMvP+oM3uNX4JXIx4VyGX8z5an8dE3dxMkwHJNYhTZ33xoqk3C/uVkUbH9JLp3DTtc
         G+4EUPCJzyYFi1CBA6G8elDzug/tcNc1e9iot7+75AS7XODujHgqJ2I48G+3QEbvxDcf
         oc+xWAWtsEQQbS5GK8Ek4JrKDEJA8Rr49uFzf7CTFayklGSVtLfxuQTdJbA3ktx/Zt0P
         AhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747976; x=1776352776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJuSzV/a9VZgvsyiqbs9gRWnFA23MYPxesTOVgY4440=;
        b=i+d3eNOJKhZHakWmmehxOMnO6Xn4HE28ojjy/i9jDsu+A9hSABu6Cd+2jP/+UCF+Gg
         meWRh9eT/BTy58XFSTl30r7UkwQRMyghn29KBsty8vj5Vq2v+WiV32z2ddq5yRjhURsn
         FAnH7a8mDR9PxvfQwMHKWu0xTYoywCwh1Z2q/AtzDrat0EQGGLD22QyeXfLlyMsEZfu5
         A1DJrraiSeh7YmzCvBlihypcuY1STAd+xrUAzZHhfYhLJDeoL+hQQLD26e+BEGLaJ3dU
         U+dlAIqs0qyCVaF24YFTn1Stm7nO0DFHE/Rxm4P7IpjB5gOMn20oY+E+lwk7ARlq6L1g
         4nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKayjcg4XAirelzuyi1fY/X9VVD0cq9V/v8dNnPrbaDdGp1YhhaOetrUvsBF61msojFB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3KWfSTFTQsUw/Z1Uwak+9T0yN7cAR8iFJjyGgWgvn9AaZH6E
	i4rDyjpYe7WIWLK9eCHb1Fbcr9siBaJogCsac0iacppFRn2nw3/Fu0e2AlkLtaaGJG/CekbYGji
	wZW+p8ChFeb7+pgA5GfsS26Q8VuGTPMWuleRppQcO9OF6c7E3eaKjzbGe3pCJ76fqgERk0p5O0p
	JAh/ct7QWb4EqdPkKozLNykUbxOLBC
X-Gm-Gg: AeBDieu7A9dvgEckfIqtTSGUhVy1NPqS5K+gSiozjB2OPO+OrQbMHZIzDOd+8OmxfNU
	krVBl53Gm5u4wQlfyymQPog54nNVdgKCTI3TDGS+wqp1d47ORnWZgnOfDNWEZ6GX7d5yObLl8w0
	D61Rfk8Nc1oSnDUBcKn+ys28/jh6Oojl9SK8DZNLMOpRWjDGbfwSoqzUid8ZZeMkXXsQuzsIzcR
	afdbLDZXPwW+z+WPvIKnNKCnFptuXz0RNyWTSAb396RMUyGAVROdmR+X6L66coZQXFfuToEnMHX
	x2hU0J8JqAtMSf6iG/oLGEcg
X-Received: by 2002:a17:902:ccc9:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b281889829mr279189205ad.41.1775747976181;
        Thu, 09 Apr 2026 08:19:36 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2b0:7e4d:f43f with SMTP id
 d9443c01a7336-2b281889829mr279188715ad.41.1775747975533; Thu, 09 Apr 2026
 08:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com> <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com> <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com> <IA3PR11MB91365041D42CB7F53DA5A98092582@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91365041D42CB7F53DA5A98092582@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 Apr 2026 19:19:23 +0400
X-Gm-Features: AQROBzCNYZ-DGOdlyKWXr6NNDhhPUzZQi2ewXWlEjaBIziQmvgTY9Fsj425SYDw
Message-ID: <CAMxuvawVL7-9+8U=Yf7_pJcsbCivgJqFStrXAtAaiBEqtZnc1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, David Hildenbrand <david@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "Qiang, Chenyi" <chenyi.qiang@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Apr 9, 2026 at 5:36=E2=80=AFAM Duan, Zhenzhong <zhenzhong.duan@inte=
l.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Edgecombe, Rick P <rick.p.edgecombe@intel.com>
> >Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
> >
> >On Fri, 2026-04-03 at 10:37 +0000, Reshetova, Elena wrote:
> >> > > > So the part about whether a triggered accept succeeds or returns=
 an
> >> > > > already accepted error is already under the control of the host.=
 > >
> >> > > > I.e., if we don't have the zeroing behavior, the host can alread=
y > >
> >> > > > cause the page to get zeroed. So I don't think anything is > >
> >> > > > regressed. Both come down to how careful the guest is about what=
 it > >
> >> > > > accepts.
> >> >
> >> > Yes, and my point is that we should not allow guest to freely double
> >> > accepting ever.
> >> > For any use case that requires releasing memory and accepting it > b=
ack, it
> >> > should be explicit action by the guest to track that memory > has be=
en
> >> > "released" (under correct and safe conditions) and then it > is ok t=
o accept
> >> > it back (even if it doesnt mean physically accepting > it) and in th=
is case
> >> > it is ok (and even strongly desired) to zero the > page to simulate =
the
> >> > normal accept behaviour.
> >
> >Hmm, it doesn't seem like you engaged with my point. Or at least I'm not
> >following what is exposed?
> >
> >So I'm going to assume you agree that this procedure would not open up a=
ny
> >specific new capabilities for the host that don't exist today. And inste=
ad you
> >are just saying that the guest should have infrastructure to not double =
accept
> >memory in the first place.
> >
> >But the problem here is not that the guest losing track of the accept st=
ate
> >actually. It is that the guest relies on the host to actually zap the S-=
EPT
> >before re-plugging memory at the same physical address space. So the gue=
st is
> >tracking that the memory is released correctly. Better tracking will not=
 help.
> >It relies on host behavior to not hit a double accept.
> >
> >TDX connect will use this "unaccept" seamcall, so I asked Zhenzhong (Cce=
d) how
> >much of what we need for that solution will just get added for TDX conne=
ct
> >anyway. It seems like we should make sure the same solution will work fo=
r both
> >SNP and TDX and keep the options open at this stage.
>
> For that solution, analog to hotplug, TDX Connect needs a hot-unplug hand=
ler to
> use "release" seamcall to unaccept private memory before unplug, that's i=
t. But
> if the zapping S-EPT will not happen in host, I think this "release" seam=
call is also
> unnecessary for TDX Connect.
>
> I also have a silly question which I looked over this thread and didn't f=
ind answer.
> Do we have to support private memory hotplug, what benefit we get to supp=
ort it?
> If we only allow shared memory plug/unplug to TD, then we don't need this=
 series.
> Guest decides to convert shared memory to private after plug and do the o=
pposite before unplug.
> This works for both TDX connect and memory unplug as memory release is im=
plicitly triggered
> in memory convert.

I did some successful experiments with modified QEMU & kernel, this
seems to work.

On virtio-mem plug, set_memory_encrypted() makes the memory private +
accepted. On unplug, make it return to shared with
set_memory_decrypted(). QEMU handles REQ_UNPLUG and can punch both
shared & guest_memfd planes (which will TDH.MEM.PAGE.REMOVE).
Re-plugging also works fine.

The virtio spec should probably be updated to explicitly define the
shared state on unplug and the private state on plug, driven by the
guest/driver. Those are KVM memory attributes, I suppose this is
generic enough.

