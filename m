Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4B47424F
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325685; cv=pass; b=e2DKy1ooDEo9MIccll7YpkFKF93zUeWTyJAWiR/VoIDAFk+2WiS9AwXm32g0o2gqK2QpgFc4KOmgwzBikc5sna1YsVdZt2B2s8l80fUKoYQU8cARE27Ap4QUa/GIJ6xZ3pfWIdvLYkdkec+R/UTD//zunl5Bl8VECdrG3sEmrK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325685; c=relaxed/simple;
	bh=o+dFtfvif9TVnSmCofN+O8+24ShzOcRw1mFy/ybi7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWxZ/59qaSPQM1oDDh1sXd5Tz48eKCaY5PZZsnp8NR63S8JeeUrVCNL4cUo5i1Ieyg5zLkv6hcT6ODiH+eJIzC6QosTAOYCoeQpZ8HLR6uVoPCtptjwHlmPkY7iwM5t0r1xpxzX1VJkPs1CifrmNRAuTe6DmViRkRJKRMbB16nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsTesBsb; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsTesBsb"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso3930e87.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 01:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790325679; cv=none;
        d=google.com; s=arc-20260327;
        b=r6XTekfdnwK3zxSMyq3NBAW5dsrXgCMRK4tz7bb8VkNOxMmJ8aWElCTH+QlEmwti9Z
         epyzlwt+eJR6Hjbg/Irnhu2vA/tlmOSqc5CGBlRPxakgK2J4TzSvzlbdMX+XXgM9WpjF
         nmAWU+mafNNeo2kEZhYt9otGBSL/qttEeas+UnKQIuibtJFR9RukAuzch9wMQNUDgJLc
         TOWh5bpEqgnqtpKhVU3oK7KNYPkw6UEMbckSYAAa+FXRsjt2FJGz9qHcq2ideMOsmMPp
         NggYo+3VH9pRMSQm3FB+c3ZUG6AhOigGQkvqMWfQlutoAKT55KZzxsFtE58wvBNufdnv
         Wx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o+dFtfvif9TVnSmCofN+O8+24ShzOcRw1mFy/ybi7lY=;
        fh=VR8v/s5IG979KaRq48ylOHte86yLXT2TFyeiEip53+U=;
        b=GCZo79fapSQRuUEfY+Fwlyj2F1KD5tQ8lIZVuQGFdYZgy31R3mKAgstqFHp1QncAkl
         7XG4FEP6H6Qr8NudaKvjvd8lizn1q5v+OlXlMF9IkyshngxRhLw4et0GCGDkSQ3ERp03
         cU5l2mFZu+JGWuf7CDG6gXWgas0h82GRw/npkF5DkPFF+dhYSjX6vyDuwLHzWSNhA0IZ
         ttLzkjDIFVyrzuLmN9QaT+yI3/6kRvXN40XWDmUMJd658HwjiNUqy5unmPlkhOcPm+rk
         F4Z3FIrPO+FOKJd6jFA4rdH2YMqE553KA9L9vpkz5Tz+Efafzrumuzqt7TGSPnw2KGBz
         GWJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790325679; x=1790930479; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+dFtfvif9TVnSmCofN+O8+24ShzOcRw1mFy/ybi7lY=;
        b=IsTesBsbVS3HXNHoE0kYeGEWRCzAmcfMNDo7kK8j4ORgY9k+hgamVlDWMglSxrxSqa
         5QeD0n5fNJLC3WpAigpXvZ75edi9BcbXGqI+GTUjUOZxs3nebBGPfJXc3Ew3CARQhs0K
         Xerp6+s+QNtCoBi1fZ93n76H3Er69uGXt36xH0APJsJw0SH35Q5WApC5ullTqZH03UYc
         RBYSGcgTHLzkBdCgsl9zbfA1g18GXUmnKcgFJvInjt1B5Zz+fl4S/eqOs7NQ5sO0I2T3
         gz/7oDSKyob+kPIU+tpHT9eN4LLJEf7gw5yGsPOspKLY5sBXJZgjTwknDc/dnHi49SLj
         vrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790325679; x=1790930479;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o+dFtfvif9TVnSmCofN+O8+24ShzOcRw1mFy/ybi7lY=;
        b=KJqYDTTx7A14NJGJDDa12irIStXZitS+G/mufkag8SgKnWrP8yCJ8xqXKqUvXU/Fs7
         lm4ouFHXTKsOsAYn0ML9j8G0/EJk0lxNLcXAKt+lYJaCs6zuP3lHsmZovAaYaZt2tset
         6QUhDKtSvR+WAHWBFs1/rebOOlGBA3v6pUsMPW3rh61E2P8AmCgEAcHWcGRY8oBtTNBc
         7N4nT/C6EsGM8vW9p2AfN9AMSUqe3JMlTFJTgHTv6+ALB3g6UaVstIyQp7ujCMFCZePz
         P1BXgVWYhBtAaeomlHftziW2jpeTl8y3jIzq5tGXfzn08wOv1XxWTWpyftDIb4fJBLA8
         BT7A==
X-Forwarded-Encrypted: i=1; AKwUvBwQsFBoaDfnMSfYv1EqjXAS6oZtpSnZlIbwEneRLrzfGGTPMSjd21xDd79WXkSbL337uTM=@vger.kernel.org
X-Gm-Message-State: AFuF++lT5ZXVAcSCFQWQ1tOuofm1KQuOEKzetFGX6/mtu7894Rr/+0R2
	wwcNyZKsL6iwdGSAYqj9ql5FgMpcwHsdrNRr/kulWo+LKnd6THcbT4RqjLtU4+Prv0Q1gjY8qUi
	QQ7hR1jJLtJgfcRm1njAEPyWm1pOfdX+Y6TmpFSzD
X-Gm-Gg: AYBFou3baYH7Sie77qtm7qGsOK64MQFPjEwQVCfGNpt8odoh5KsKveIk2lKpIFSRBpu
	uSSubprdp4mlVEG5kY3Zen+47mVDJbTMXonYiS9tVCdMkYEVC2weNRHD/Lle6eOv6eAqc9xsUDN
	pk1mELC+OomNYQJ1UQSIS7lD8vS31cvit8v51FmlqSQ8N7ZGrEms77167EXrqqm5XnJ9/tnfWTm
	4lDMHCV+D39kjWemfCZNOHZjXSBgkUwtcUsIfZ7JEMuNQVTH25VDkOGwBSboUAIgz0i4PFGEyrB
	iBFD2EWGZySYSRtWvA0kX/GfhWHeOZjdCLCFsUQc/wxMNY/PH6e8KAhc0YNwhqI8chyvPtXlx4E
	gMeFKqcBU3TMPMBSJV0k29roO
X-Received: by 2002:ac2:499b:0:b0:5b8:e83d:6c23 with SMTP id
 2adb3069b0e04-5b8e83d6d52mr34962e87.15.1790325678596; Fri, 25 Sep 2026
 01:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org> <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
In-Reply-To: <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 25 Sep 2026 09:40:42 +0100
X-Gm-Features: AclHuK8wuRNyKESPsObp4QvTkrVR3_lCINqfI6LnWNaBHbsf2BpkSVcq1Eie6oU
Message-ID: <CA+EHjTz+WgXEW5RTxXf4oGeEb1Tsm5Ha4nOc4S1jBcp7jxP4+A@mail.gmail.com>
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
To: Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>, amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com, 
	ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com, 
	fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org, 
	kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com, 
	michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev, 
	Peter Xu <peterx@redhat.com>, pheragu@quicinc.com, pkondeti@qti.qualcomm.com, 
	prty@google.com, psalian@google.com, qinkun@google.com, seanjc@google.com, 
	shan.gavin@gmail.com, shivankg@amd.com, sidtelang@google.com, 
	suzuki.poulose@arm.com, tatashin@google.com, vannapurve@google.com, 
	vbabka@suse.com, wyihan@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

On Thu, 17 Sep 2026 19:41:14 +0100, Ackerley Tng <ackerleytng@google.com> wrote:
[...]
> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
> guest had requested for conversion first? This might be the same/similar
> problem.

Sorry, I missed this.

Yes, for unsharing. I'd said EL2 does the transition first and the
host then accepts the conversion [1]. That holds for sharing, but for
unsharing with guest_memfd the host would have to convert to private
first, and only then could EL2 complete the unshare. Otherwise a
failed conversion (-EAGAIN) leaves the host holding a page it can no
longer access.

As with CCA, the unshare would stay pending until the host checks on
KVM_RUN that the range is private, like the check Sean described [2].
I don't think the per-VM list in the host is required, though: EL2
already takes the VM's lock for the transition, so it can track the
pending request and reject conflicts there.

Cheers,
/fuad

[1] https://lore.kernel.org/all/CA+EHjTwLRzrq0vY0-OosENJ2Gkknerux53aVBj0zGRQUkRQP=A@mail.gmail.com/
[2] https://lore.kernel.org/all/aqw_uBIYig_uo5Eq@google.com/
