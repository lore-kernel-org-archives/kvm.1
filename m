Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793643403;
	b=WQgdCCsENkFW0uAysA2NurtbkI1JNfIDC+/uxjL7u8QucHf5OL6ZIt1e3legvF8RMQfp
	 QN4f3GNeDYsVSl302mEZ4GbZBVwUU7B5utUWIDStX2c55j5LPhHMs0nhKCjHuyGqKFZGD
	 QSGaFIsiqn8+J/uVM0Ogf1T1P6oZouyTZ0KtLZGJYLlmR9n20EZXfpRrnz90pZd6XINxm
	 J5NT4vyK8LQlXr9udqX/bXf8QgYK7xLI4P2g1C8YvR3S5J+x2pBH+qGwLcvwB283dbbUL
	 vERRogJUE7bKmCEomSge+YV6thohWXhiu+JSNBlqkwDihXgjjHNUKshNDvoi1+QPdxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643403;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vr76CxOCRE/GBSNADyNpvIHyisaI2BQrg6w5s2zNVBI=;
	b=E9NYv8vUxh3Ti3YO1YJqtfVj+pBn6g2cTch9N8t3xtGT1elgF+CXLEvlDalhS8ua2MXi
	 fA9/Zs8gkpHbgRo7tKUUzoi46lFbijWBidccbw/kJvxF27i6V4ybgHC2KcDANMhkzDMPA
	 mfzhLTMwQObIttXCVNeRbx0YdKKHyebRihCdsyo8AWqpxV5XkQxmvehbLnIzov5z3mlZ3
	 Lu60aUVg4kNNgxiBBXqLsYc/8XnKLMME2VcEXtDYUk9XyOGWRuxAC+8PbXuwXIQ/2qFkd
	 5iDGX7xLn7929dhncH6jUsntXrHn6GGuLLIPrx5C8+KjpDGEXAt3SvaESiqaFKWlwYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="csX2/Mq6";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RBtItvv9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF49606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF49606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=csX2/Mq6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RBtItvv9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793643402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr76CxOCRE/GBSNADyNpvIHyisaI2BQrg6w5s2zNVBI=;
	b=csX2/Mq60dvyOmYe2W62vesMdP3+xSz+18C6eRNKpvRyNm7yqLGwds4gJ0s53AwcL0H+UG
	S2daqYnNH+4mX09JF38CEzp2AlUaWfw9JNSXfti0O638tJ/XFZpKDnSwkGyJ7J/+6oEmU1
	ys0TFgNseD0xCL92jpYcuS5f4sEijSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-ZDHyuHX3Mqq1rp8O6E6vKQ-1; Mon, 02 Nov 2026 13:16:40 -0500
X-MC-Unique: ZDHyuHX3Mqq1rp8O6E6vKQ-1
X-Mimecast-MFC-AGG-ID: ZDHyuHX3Mqq1rp8O6E6vKQ_1793643399
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e17d30a79so1704825f8f.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 10:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793643399; cv=none;
        d=google.com; s=arc-20260327;
        b=EeTUKj7m7FQxJh1QJaqJfaoJQ42lS44kDxqtIT2DHOVQtN/yWWQ1sjnzWiGuPGXexK
         Q6uoFQVcEmjjA2ZXGqUvuro74YFvZkaS+E85TkInqMsp9apKoktFzUypyRgwWyX5IjLD
         IcXlGUe1ZnipKRpVQtiIRu0T/PWyD8YufMiT05xstIFACTMTh5zgJj/L49DpfV2nxsQK
         YrjFelBQ+wWwW+uFvxWNdTveieVYlHC3fzeE0GGYdeRZdAk9806EVVz4W+LS5kj7pQEh
         6+GzxCv2hJCzNuTgJxQdD8k69mdrK8191ksWDgxT30EIc8bWife7r4CDoW45ZHeHErs1
         7/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vr76CxOCRE/GBSNADyNpvIHyisaI2BQrg6w5s2zNVBI=;
        fh=45HxpdruTs1JGgLxThRQyyP3y8DEMM2jIzZxidPzRRQ=;
        b=RcX6QICOExV+QDeLS8txaZYCjnar9JXcad+CNAPUMMYIiT2cIbo4C+plF71zykGDAJ
         VtcyX28o8n37pTJr1hdO0dM96/vBOjSL0amFh0DEFRj/0vK5/mR9DSkztISmuhBxkXEP
         reYX+e1OwphfVFBB6IyR4TDQZxkihGa9I4JUQY4LGKeZ/PvJ6BlcpEh/rZXQygQTaiWM
         3RroEx4eZePhzig2OPxTf9o2gzBQL+C1sDgjTR4LhXBpI/Ja+tTFz68TEwQ+ZRLhG1Hs
         UKpZ3uwxZVakf9Qrrfog3CxkVMONezR3X/wMa/SDxSVk8qAOtxjERY8G2lP1ea34tjOh
         cyqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793643399; x=1794248199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vr76CxOCRE/GBSNADyNpvIHyisaI2BQrg6w5s2zNVBI=;
        b=RBtItvv9B31dT2u7K4qBo7ogPBqQBFRekOBj8c2AW1B8qU2YCNuRIjXmM1K8DsfXll
         lJYoOB4vePKBeQNejFV0l//LOLpiI8BuhWCtMoABEyhiwWuGXY0KVfomlq8Miz1B6eg2
         9DD7Sg08tmOMONPu9o17SRBvmkerPrUo+/j+Zo80Q5b8hekKMGtK/ioCm9nlT8ofQynJ
         kpQz56YhxC8SQvzBrPbX/GTJfjWi35GOpmH/LwWJ4zJRFeLPGwk8z5jx8RNovaPSfTVa
         pwyBqUhHgQoKyfpNGry1Mgf7F5y9xq4GVbLsQam4EsJ+/j5R+GuwHFGqt3vPcTofwCjV
         PRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643399; x=1794248199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vr76CxOCRE/GBSNADyNpvIHyisaI2BQrg6w5s2zNVBI=;
        b=sI0TE30YwjzvOeHfNEIe57BzJ1M6n4NizW2R0lL9FSTlJXDOqB0ViKYi5V6jo5OKhL
         e08nfNVQslADWzWfkYTU1uLuLD+sC0vJgSJeJ8OJ+J0ZcY7PthuexczanJ61Rt4T+RjS
         n4svIA7P1jFDMR0ITSk38ZQA9fbxZqFtHxFRszwTGYMr2Vj781qZlamMME+Y8ICEwbmj
         fTcYO8mNJKZRiyVYq4krRlwBQgHXt4F2QnPqC/r0VZE3C63FV2IJdfTki9j8TcLbB4Qi
         Qnh74sffoji6wwtsPABSCWzyu/aMumjqry4LRguaVkFU8OrZu69kGu5ip0LVWaJOdlBx
         eoDw==
X-Forwarded-Encrypted: i=1; AKwUvBy2T6RIOxAcY6nu/qdvbRSR5lKLwrV/cVjXXyz5N+6jC2wkW2acoiD4yp4xBxXyDHK9M8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pTfyHNklaLlfQXgcGpdarnInCgUp+Zf83/hZbRdgQINhKWS/o
	usKZcP35EA1XwaYinkuVDQ4ZMukNblt+kOdEoKIjIe93z6cXXcujqDrvLn4fjnQkD+uTFhnx/rh
	UYl+VQptfknA2EcpRkAnB5nuIRdtZxLAbvCZowghGAIFVpo41xgijttn0OB297AuC/jY8SBu0Zg
	6jJibvyHCof4YX8kyTrSNG4hD/2erM
X-Gm-Gg: AYBFou21gq1iQkvE2ZbqXlJAnNGwUUaOq9vkblxEqlWM4k8htZdVHUqo+LOncLU5WIa
	9ldJ6GpEN1UlLmTZVI2PYdl0a+10VZKIwX3Y7WZveheWaRx5oES1e5M2B624Kvm8VsZvhG+KkUj
	Wv0P4dyvgK7y8Vw8gJ00PKia7JJIJ3oNAKQ7ODterIvpWRDjBc0Xp6h1+QmeTECmsfJ3jN83pmI
	ICmCD5CCL1rRkTaUHzxsn+kX9Me5xXFuuoEBwfk8+MLbufXAjzEg3ctIsVV
X-Received: by 2002:adf:e003:0:10b0:48d:ffa3:714 with SMTP id ffacd0b85a97d-48e6e2f2964mr20349184f8f.19.1793643399445;
        Mon, 02 Nov 2026 10:16:39 -0800 (PST)
X-Received: by 2002:adf:e003:0:10b0:48d:ffa3:714 with SMTP id
 ffacd0b85a97d-48e6e2f2964mr20349156f8f.19.1793643399087; Mon, 02 Nov 2026
 10:16:39 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <kuph5i8x2d0.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb> <20261031090529.65240-1-amirmohammad.eftekhar@cispa.de>
In-Reply-To: <20261031090529.65240-1-amirmohammad.eftekhar@cispa.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Nov 2026 19:16:27 +0100
X-Gm-Features: AclHuK_YXcxMZDa_2uVf-DOKYVLREH6PFG-uQQ0h0kF_GFc_0-Dn7EAhewjC8OI
Message-ID: <CABgObfYZde9RhwbPkq95uy6pNdyPFS48k9HvzCdGPggQ6reHSQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: seanjc@google.com, vkuznets@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amirmohammadeftekhar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 10:05=E2=80=AFAM Amirmohammad Eftekhar
<amirmohammad.eftekhar@cispa.de> wrote:
>
> evmcs_field_offset() bounds-checks the guest-supplied field index against
> nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] without an
> array_index_nospec() clamp, unlike its vmcs12 counterpart
> get_vmcs12_field_offset().
>
> A regular VMREAD instruction is allowed while an enlightened VMCS is acti=
ve
> since 6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD when Enlightened VMCS is in
> use"), and it reaches evmcs_field_offset() with a guest-supplied field
> encoding. Because the index is not clamped, the guest may be able to
> speculatively access past the bound check and read out of bounds of
> vmcs_field_to_evmcs_1[] (Spectre v1). The leaked value is only the u16
> 'offset', so the exposure is limited.
>
> The other callers of evmcs_field_offset() are not under direct guest
> control, but the array_index_nospec() clamp does not hurt them.
>
> Clamp the index with array_index_nospec(), mirroring
> get_vmcs12_field_offset().
>
> Fixes: 6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD when Enlightened VMCS is in=
 use")
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---

Queued, thanks.

Paolo

