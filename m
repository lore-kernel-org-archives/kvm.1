Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821E52ED42
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874495; cv=none; b=qvU8OBtDvsw5CYLg8J0zkBiNZysvMAAhvtcET6P2F6C5+PHTZq30ZPYec9Kic2anjvNi5FpIa2L4flEssZAfVDuVbRjao7EdtTsOf2I+UAaguZ7D4JdRlB+Khnsat55x0tLHibXGFrHJxDSvs2aidJm4iAFFSIRAvqYphFGbKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874495; c=relaxed/simple;
	bh=7Wddo+fD0swIzF4dXTBlpMKytInTharTjwZn2tx67OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biFFg8Fn1Hp2SBmI0q/A/vMlfY81BVMlVQqZUMWNDzaueOXKazri+O0F+u5qlKfTeM3LHGOEUI7WVhGD2zJAxXpyd+RCBXN6xmW8wABffS1DQLGdZxB4Qmu61uPgREhJ1ZY0TxOY6C486aTNpmE/M6yB/1eXtgtmn1MEZnvQcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzS187LK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzS187LK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788874475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RRoN2KDjRYUqGQ6oqCABS6BHuNVftn8VOXlRsqF+JoM=;
	b=OzS187LKfUvpywnEer4V1Xwd+FkCAT9Kw3miL5cpmNfXalsZaso+RCO51luMy9Cj6XDj/D
	pkQyBXi3/wVoUDZUP4qcUmrHAVOO2+40KMqZ/l2ddx4PxAQOAxtUGqHmNzynhXiRu6VcQy
	95W3I6EqCvSFwB61ajiCuZNjIkhJvfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-rK8nRPTDMmWj2E2eN-LQmA-1; Tue,
 08 Sep 2026 09:34:33 -0400
X-MC-Unique: rK8nRPTDMmWj2E2eN-LQmA-1
X-Mimecast-MFC-AGG-ID: rK8nRPTDMmWj2E2eN-LQmA_1788874472
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BBC2195E919
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 13:34:32 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C1121955F11;
	Tue,  8 Sep 2026 13:34:31 +0000 (UTC)
Message-ID: <81253f32-39fb-4e47-bedf-f5ab7d8e18a6@redhat.com>
Date: Tue, 8 Sep 2026 15:34:29 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2] svm: Add SMI handler for
 svm_intr_intercept_mix_smi test
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20260820-add_smi_handler-v2-1-80d7316d5dde@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260820-add_smi_handler-v2-1-80d7316d5dde@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/20/26 10:49, Ryosuke Yasuoka wrote:
> L1 intercepts L2's SMI and the SMI is still pending at L0. When L1
> re-enables GIF via stgi(), L0 delivers the SMI to L1.
> 
> If SMBASE has not been relocated and no SMI handler has been installed,
> L1 enters SMM and executes garbage at the default entry point, causing
> an abort.
> 
> Install a trivial SMI handler at the default SMBASE entry point so L1
> can return from SMM.

Applied, with an extra note that you can't have multiple processors 
using the same SMBASE area at the same time.

Paolo

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
> Changes in v2:
> - Update commit messages and comments based on Maxim feedback.
> - No code updates
> - Link to v1: https://lore.kernel.org/r/20260818133445.8688-1-ryasuoka@redhat.com
> ---
>   x86/svm_tests.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index ccbab1d0..639da786 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -3543,8 +3543,36 @@ static void svm_intr_intercept_mix_smi_guest(struct svm_test *test)
>   	report(0, "must not reach here");
>   }
>   
> +#define SMBASE	0x30000
> +#define SMBASE_ENTRY	(SMBASE + 0x8000)
> +#define RSM_OPCODE	0xaa0f
> +
> +/*
> + * Install a trivial SMI handler at the default SMBASE entry point as a
> + * fallback for when SMBASE has not been relocated and no SMI handler has
> + * been installed. Without this, entering SMM executes garbage at the
> + * default entry point and aborts.
> + *
> + * If running with a firmware that supports SMM, it will relocate SMBASE
> + * and install its own handler, so the handler installed here will be
> + * safely ignored.
> + *
> + * The default SMBASE (0x30000) region is safe to write to: flat.lds places
> + * all sections starting at 4MB, and the page allocator starts after edata.
> + */
> +static void install_smi_handler(void)
> +{
> +	WRITE_ONCE(*(u16 *)SMBASE_ENTRY, RSM_OPCODE);
> +}
> +
>   static void svm_intr_intercept_mix_smi(void)
>   {
> +	/*
> +	 * L1 intercepts L2's SMI and the SMI is still pending at L0.
> +	 * When L1 re-enables GIF via stgi(), L0 delivers the SMI to L1.
> +	 */
> +	install_smi_handler();
> +
>   	vmcb_set_intercept(INTERCEPT_SMI);
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
>   	test_set_guest(svm_intr_intercept_mix_smi_guest);
> 
> ---
> base-commit: 033ab80d18bca31a6e428b877518883c90c3a2aa
> change-id: 20260820-add_smi_handler-063b3d117141
> 
> Best regards,

