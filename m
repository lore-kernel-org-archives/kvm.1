Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641088;
	b=YxGQYwJ9FVvMEhoiD5dVHUH1BQKKB3Cz25yeVE5297+TQKrXUAXf+YdDmzGq5usAxpWv
	 rXjpyLuqMQMC/9Ldgw9x3QfldK7Ft8Mc3WHZX8NKJsWTK4fvZN8TFiOXBi0XzdLld28eo
	 wkk7XyJAcsMH68He2SBSxKGbgVBOPZHzCyAYgBJixLW+gIVVyVTDX/NwS1dK1YYg2FGOw
	 Q6Bwf2la99EPvpb7V6Ca7c+ZC5+fpk/RPuQB/NGMqn1HbUIHMSQSAnHUSt5hfLt4rBPPU
	 GzAk37QF4Cc0NsFVMBH3rClWtyKG7egFYQQbuG6tUjfAKRMSZrFP3npM18i72Oo59Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
	b=NQG8yiGZQduV3vQIT1ykTUedsIhPDz/ehOj3q8Qk01KeasxOPUK/Pc3eg2G6RVPSpWVd
	 ivP7LEB87V2QUB03qCgXJtyLZ4Btj91b60Aqh2/40162KivUV9UQ656ZzXkErurOyXKs7
	 xNtk5KQy7HARPUYQBQS7BtmSh2pxkb6IemnqU7bc0zNSoGgX5GWLE2jbGAWv9vV3L2lBv
	 8fuYTFF6x7jyuabU07ifRYVqdtmoHa2ngeEtCk/Z7aimYF2GcGHhmO2wETfp4lMAzRp/u
	 Rbyzyg3SJw8ev6gpvuQhQN8cWOZfTeNE2dOCzzBSKEOcL4Za1Jpz5G7FxtffndNXg8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=cBk9L98w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B52606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 03:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42B52606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=cBk9L98w
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so2032579a12.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 20:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641086; cv=none;
        d=google.com; s=arc-20260327;
        b=V+SGE3C58EDMWbXylsfDrhL3KwSjEna2Cf1fYyVRszPn1emtqNe+Z4NqYoLlB1kp9R
         XQ6sjwIn6pOv5WOT3zjydskKFSKv5VeJsrHWAW0eY+hVqZ47SJQHn23hnlb/IqCbVHDm
         OMdTlxzmcYvucz8ujJzbq/AVls+KagYwcyOgOc8ySYFGrZwNHu3Qkm3B2YPfaEcntIzm
         V5GZcbIu+8hu/8J+wbUw/XqXDA7B/uWSCr28U9KNKItq1DBUrQiDTc9zzY99Cwyr/8gW
         Q958/ORXv9jUXAnyUlisdotOJxgqPsB2sJ9RtBrrnkS+dGCBa4J/QsmRvZjxZw1zpC2x
         K7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        fh=FP4co7Vhs2GP5j1p2lx613lLBtdnE9rpl1e10z15DbM=;
        b=Z/Q0adcWRjVtAxSCANqq166kbMYfrZq2OGvyWLpc0zIPSedO+DRYS3rss+lG398Cse
         lzE1Bx3TYup0XTmI6ewhxb9yRGZ0/HkW9CumaZfVIl21U2198kj58WvDJtstwPl3M9Fk
         tGUV4fkt9d+2H3K1geSFlAw9+qOmJmZxgBXWrDJ8uLWVyh6+yTkv7JzmI4x2PgwtVwO8
         /JJkqwB49peBhyGTFA9NLOk5gJfZQShsdI05Z6Oas7NuMYSX+/wL4Nlz3A9DX60O+CPM
         XYsk6jZwKitLIFXt2+5BJTBHZym6d3aUKMRu+hVS/S3FXqnaxKM+IGRYgTJdPxsTF+x1
         W79g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792641086; x=1793245886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=cBk9L98wdr+I57yyKoGK6ehYZVVWDgUcVA0vBev183FVZZ9gL7bx2aAI9FHk2T2N+g
         lYnDbd8lxkbmGp6fxdfORrV33M/cwga8pi3bHVDROh60aogMaMKHgRsc60E5datA891T
         aoY1tB5X1q6xy9NZolD/k5TifKRm71ur+T75WWkkRuneEyWes41oiLntbMg4lL5X4hIH
         4N9J3nmbnw1PqmHfqXMpUjdz8piQsbYLQYPGREsC1I+SWMwd6mJYf/XCYm+48Nr7XZ5t
         fKBT27EQbzvbH75Hv8N8EjbsipbFrCebOASLNVdlr/oloQYlc+ehjIi8GxJT7Uj2JART
         +Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641086; x=1793245886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=CsbicHWdRoAq7K2mugezMXhBm7amP7d1InTXnLHXbtLnUpwCjBbR8h4/S5QM+MVEKh
         i85lc51GwUSWrJPZII6fuQrRprnMi4VvpnuMmjWpnNO6QpeXh4IzkoDc4kQuMEkf/6Hq
         XxCb1g2xokCWSqRcJAWhl1SyPKUHt6rFjSMIVxw4T0iiqSZiD1hSFiHg71UuDA43v5jc
         UY3NmfUWiTnrt9JeG9F6YcNI3rvFHR+4whfPbZmK+rbmZidbsFYB9P0R5joYDfNgCXD4
         8VAK+wDWLvG0R8657am15DrT8OIUz6hRSsEWQjWxZ4gwri/fKuPpTyNaFBabBhQKTWfk
         uHGg==
X-Forwarded-Encrypted: i=1; AKwUvBxprzRHPXgedMoYHDK8KJuksjTV4B5P5Q4HKZAoj9zt6DyjyaFDNbdu+eg22yTJV6GQOjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJofQK8EM1bUjUjk/Vn5FnQh9gcb2wYj5d1t65vjyEurNiSrNs9
	CvfVu1J9xRQeQUUwC+QD36vOL9yI0Pkf3GmCpan2JyW2afPBNTqFbtW7S/JePyjMBq4CkmDT4cw
	FZlgCzlLy6Z4OVN6vYuu7wD4mQOcUUdba52VIbnxrEw==
X-Gm-Gg: AYBFou19XRwpJMQIOWKwjOXZWaUCmfn2JBjlBuGqJdtbxEX0gfd6nrEaxi9KxbM7jt2
	+f87+5Fpak10MrnVTfX8/3Bp4JMt/4DhrAOoPryUdK34fcVPKl5+R2V3yY020ScBkLO+Qtv8fFu
	21Md2LpSAxscfdDylnRtAOs2Bnrj5cJ2axL8ySv8ln39vhgG7KzP100if1EFPEb0M08tF6HVuvY
	a5rsBLPeYL8jr4wzrl0W25zF9w/9qvIvKSzRpXT/EF9BvyS7UyIt2x60i3Zk+THqgPpp108+a88
	o1/QAGiqPNboyx59xFhs/b4sFfZGXfZe2q0M+Sy2i3RQADx4QYpbqyWSINRByqtD4Z0WSnanasD
	8c33x/sLltUtmMsYB1C4nbbjIN9B7kTZrET2OWDXYbS0GGESRTDbzXHBtAdUPo5BDiPA=
X-Received: by 2002:a05:6402:400b:b0:6b4:2185:7147 with SMTP id
 4fb4d7f45d1cf-6b4218572dbmr568868a12.15.1792641085570; Wed, 21 Oct 2026
 20:51:25 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
 <atlINfvlXY4wMbpO@google.com> <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
 <atl6K2Juy6Bh29lh@google.com>
In-Reply-To: <atl6K2Juy6Bh29lh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:50:49 -0400
X-Gm-Features: AclHuK9es7KH6zjO9m5YDGIDDY6Onq6kZ5W4q1tuNZUyMat9PK3sQU18xuWoZac
Message-ID: <CA+CK2bB9xoAWP0kC+KtXeDTdwt0kWqb-PLHN=6DsA=mnRpMfxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:51=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 08:41 PM, Pasha Tatashin wrote:
> > > > >  /**
> > > > >   * struct memfd_luo_ser - Main serialization structure for a mem=
fd.
> > > > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > > > >   * @pos:       The file's current position (f_pos).
> > > > >   * @size:      The total size of the file in bytes (i_size).
> > > > >   * @seals:     The seals present on the memfd. The seals are uAB=
I so it is safe
> > > > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > > > >   *             struct memfd_luo_folio_ser.
> > > > >   */
> > > > >  struct memfd_luo_ser {
> > > > > +       struct luo_feature_hdr features;
> > > >
> > > > I have not looked into this yet, but I would prefer to use some kin=
d
> > > > of macro constructor for serialized structs. That way, they will
> > > > automatically include the header, making it easier to search the co=
de
> > > > for what is actually preserved versus what exists only in this kern=
el.
> > >
> > > If you want to know what is preserved don't you just look at
> > > include/linux/kho/abi?
> >
> > Yes, and having it initialized and declared in the code correctly with
> > proper macros and verified just gives the right handling and avoids
> > making silly mistakes. The second reason is so we never forget to
> > include the header, and to make it expandable and easy for everyone to
> > use. I think this kind of constructor is just useful overall. Are
> > there any reasons why we wouldn't want to use it?
> >
> > > > So, I think something like this:
> > > > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > > > struct luo_ser_hdr {
> > > >     __u32 total_size;
> > >
> > > Why do we need the size? I'm not really opposed to it I just don't
> > > understand what problem it solves.
> > [...]
> > > The luo_ser_hdr is needed for top-level file handler and FLB ser
> > > structs. Those structs are always dynamically allocated and preserved
> > > with KHO.
> >
> > The top level is not enough. I think it is needed for every single
> > serialized struct in kho/abi - the blocks, the FLBs, etc. They all
> > must
> > be expandable in case we need to allow that. Let's have future
> > protection for everything that gets preserved.
> >
> > For example, take a look at vCPU preservation:
> > https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@sol=
een.com
> > https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@so=
leen.com
> >
> > +struct kvm_vcpu_ser {
> > +    u32 vcpu_id;
> > +    u32 flags;
> > +    u64 vm_token;
> > +    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
> > +};
> >
> > We might want to add fields to the arch-independent part, and we also
> > absolutely must keep the arch-dependent parts expandable. Therefore,
> > the header needs to stay small and flexible enough to grow as needed.
>
> Hm, anything that is dynamically allocated can have it, but anything
> that it is embedded directly or in an array cannot, because those
> structs cannot grow anyway. So I agree it's not exclusive to the
> top-level FLB and FH structs. But I would push back on any a mandate
> that _every_ struct in include/linux/kho/abi needs it.

OK, we should *aspire* to convert as many serialized structs as
possible to the versioned format by default, and require a very strong
justification for any exceptions (such as tightly packed arrays or
block set entries). Even in those cases, we should be certain that
omitting
the header saves meaningful memory and that we are not shooting
ourselves in the foot if we later decide to replace those container
primitives or need to evolve the entries independently.

Right now, shared serialized primitives like kho_vmalloc and
kho_block_header_ser do not have proper versioning at all, and because
they are used by many clients, updating them is already problematic.
We can't simply rely on top-level FH flags to version everything:
since these primitives are shared across handlers, any change to them
would otherwise require updating every FH that uses them.

BTW, since these primitives live in KHO and all the ABI headers are in
include/linux/kho/abi/, perhaps this header format, versioning, and
the declaration macros should be part of KHO rather than LUO (e.g.,
struct kho_ser_hdr and DECLARE_KHO_SER)? Then LUO would just focus
exporting FD preservation-capabilities to userspace, as it deals only
with FDs, not internal representation. There should also be a global
switch that shows the KHO version the kernel is using, perhaps via
sysfs.
