Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E953D9666
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942979; cv=none; b=GuwrlJPp5/8/rux6MSkvB/WsSwHlqNcT2ctfsfLTZQnDvMoXkMblqn9W0wl6AyOYHCuoE2lzQYHD25bGP20ycQJREc0dSHHSZt8NrRtZx74wi0xP8QdhA9EOZa1SLb8Th5HVDlusg7SzLHtUywt+cug9sUnPySKK6tAo86PkyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942979; c=relaxed/simple;
	bh=v6Y3fa7kX8cOD75Cvz/PmmMEKU1iHPrCF8yX1Opx2XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oaw2JzElRR7IuJWS9/WaG+QpTwVAI8IN0VKHOvm8CtCPkJM7hv1NNWKsNaUdMmFbanT5ec0aGw0qXL4ImEHn6zEfqoxX2WosrzaqskaoanCk/2BiaWMMQJ9fR3wXJ85DKNzWPM0XKYDBd4rRpi8mhUUfn/uf+PwZticLtj7k8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlkUvU5r; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlkUvU5r"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bf5ea9d140eso203893066b.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780942977; x=1781547777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SosLKBVvUMZz/rhhs2ynRuPONsMChlqS4SGtsVqD34c=;
        b=nlkUvU5rYKpPBZ8e7Se1aJxyOlZVQIkZuhDCtojc7dH9reIeDRNw+eBQAYZk7ggp7I
         6emR84y3Kc+biVUwSdL3LYbDxRW4y64NZhh7UDK+DlXTTlae/YPL6FvW9C7Oo/QrJK+u
         NoTtlnxth31NkJXGUGMFM2HfdpFcc19afFbg0zIotoXjLuaLOsLjaAknyeJRN9clCGYt
         piKGTrab59KsR37XgUisSvRMAIRGhauY328MLeRJ/py3LBAc04A2JT4wEBaONJ9rq4kN
         3vNjSe8hQI7lCF71EX9WlAjW547JjZyqogE9XyAqzz+mSInZell1JIqSy96jp7rNQvKG
         aWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942977; x=1781547777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SosLKBVvUMZz/rhhs2ynRuPONsMChlqS4SGtsVqD34c=;
        b=oZSOmvBOuTFzYf6JjQsb9+PSEOkYxMNFtsqi/Ql4HNHVCzRXD3V4nknVvdkdjwRBEy
         fFlf2iPfN8aeBRdmUhq3pj1HoAKf+B6m1OgR66i08c67EV0d6OQ5VSGyq7Kv/A7rz481
         tEQST8O0kRjsxjNud6uUZq4QJyzU7hZBnqprnwQZo/t//nZhvRxreyvDxtfJOpQ6Odiy
         uiIig6y078VcxzuiKd/eNYQzZ0ldQhk8V5j4r0Z0ZVL3uU0cnWsMeHPtuzdoAYOpIVhM
         tg6/9oISs1XCRp9YuFNLKiQuzXAkF21Y0OSaRqxhYQSbP664DDctThBJIo8CEEmvarnu
         HMnA==
X-Gm-Message-State: AOJu0Yyel/jwsc2zK2XAgIJ50kvvTTBOCLTzqQ7+xoJbAxJ5ysCg8Gbe
	+DvQs++MJtmslOVGPuPFdUyfg+tzPFQ3NV5K583a8PSremxFdooPcP/UjskBQLE4T9U/k7OkpW7
	SbT2LGLxw5UxNmZS81w==
X-Received: from ejet27.prod.google.com ([2002:a17:906:179b:b0:bf0:cf6e:c85])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d89:b0:bee:72b9:f5a4 with SMTP id a640c23a62f3a-bf3a70fdd2emr636456966b.13.1780942976837;
 Mon, 08 Jun 2026 11:22:56 -0700 (PDT)
Date: Mon, 08 Jun 2026 18:22:56 +0000
In-Reply-To: <20260605172557.DC6A71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <4b2216f5c459fe699a3f62464cbc765624e20ae6.1780676742.git.tarunsahu@google.com>
 <20260605172557.DC6A71F00898@smtp.kernel.org>
Message-ID: <9huz5x3syjr3.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 07/10] kvm: guest_memfd_luo: add support for
 guest_memfd preservation
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sashiko-bot@kernel.org writes:

> [ ... ]
>> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	struct gmem_file *gmem_file = file->private_data;
>> +	struct kvm *kvm = gmem_file->kvm;
>
> [Severity: Critical]
> Does this code dereference file->private_data before confirming the file
> is actually a guest_memfd?
>
> The LUO framework might pass unrelated file descriptors where
> private_data is NULL. By extracting gmem_file->kvm before checking
> inode->i_sb->s_magic, could this cause a NULL pointer dereference
> when evaluating unrelated files?

Oops, This is a bug, I will update it.

>
>> +
>> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
>> +		return 0;
>> +
> [ ... ]
>> +static int kvm_gmem_luo_preserve(struct liveupdate_file_op_args *args)
>> +{
> [ ... ]
>> +	end_index = size >> PAGE_SHIFT;
>> +
>> +	ser = kho_alloc_preserve(sizeof(*ser));
>
> [Severity: High]
> Could this call trigger a NULL pointer dereference if the KHO subsystem
> is disabled?
>
> According to the KHO subsystem guidelines, all callers must explicitly
> gate KHO usage on kho_is_enabled(). It looks like kvm_gmem_luo_init()
> registers the file handler unconditionally, and this path invokes
> kho_alloc_preserve() and other KHO serialization APIs without checking.
>
> Should this function (or the initialization) verify kho_is_enabled()
> before interacting with the KHO subsystem?

Luo already does the check, this review in incorrect.

> [ ... ]
>> +static void kvm_gmem_luo_finish(struct liveupdate_file_op_args *args)
>> +{
>> +	struct guest_memfd_luo_ser *ser;
>> +	struct guest_memfd_luo_folio_ser *folios_ser;
>> +
>> +	/* Nothing to be done here, if retrieve_status was successful or errored,
>> +	 * Cleanup is taken care of in retrieval call.
>> +	 */
>> +	if (args->retrieve_status)
>> +		return;
>
> [Severity: High]
> Does this logic inversion cause a double-free on successful retrieval?
>
> In kvm_gmem_luo_retrieve(), a successful retrieval frees the ser struct
> but leaves args->serialized_data intact:
>
> kvm_gmem_luo_retrieve()
>     kho_restore_free(ser);
>     return 0;
>
> Because standard Linux error handling uses 0 for success,
> if (args->retrieve_status) evaluates to false on success, causing this
> function to fall through instead of returning.
>
> Could this lead to accessing the freed ser struct, erroneously putting
> active folios, and calling kho_restore_free() a second time?

retrieve_status is 1 when successful not 0, this review is incorrect.

