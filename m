Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84E416D01;
	Wed,  1 Jul 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921254; cv=none; b=Cp09jOrbfXRzB4W5Bddfpr63TcfFVIeE329oGd/HPbqk/yRY3w9PinJ1ZkxkspkwyLeMVbsTbXwTbWLsbqjg0ufVKEM0aTuHnS3+hpnpHSXXI+BVFLZtlfe4yMQRLDzHRw7UEsseIuSFhz+RuMlmTTbT4/ZRgI30H9qu7Ec1sVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921254; c=relaxed/simple;
	bh=G1qx4lJ/FOReXWbODYP3XMesRUo+qlxSfgomKdm87DA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f7zTUP98vzOFo1KFPqQMogXU9/vbSR71GFOOcgYLw+8l3yAa8eXfzQS7OEQdr6i9sqsecVBjmdPl+E3AfAXoza7SLO97G0UEDuFCgLaV0GjfhpxB+c1BUpEEJpyC6RXpIK1oCdEZhNu3c4HgdJsXsqeWQF0nPHcg9qDk99sPZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEOXN1Cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEOXN1Cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90E71F000E9;
	Wed,  1 Jul 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782921253;
	bh=Day1pHQbKZLb168bI+sP1UZxbLRw56ZZ/BDr3gtOMiQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=OEOXN1CbmqbmzOHS4xMU9zz61FwVoCI0s68qSt/fMFnPQAtQDSI9WRjlK+tUTfm7W
	 YMGFkMn0G8o79DO1GWLJHoAFBmpvbYb7AMyNFQ1CBAOH3lIZ1XdwqwfXztENUdEGOP
	 VsJ8LHmL5fgC5eFahjw3d+/4fx6zGP30xf5NOjXyx57RHcxnBNqPOqpIcjlEu09pgX
	 kM2HD76Qskh2xjdNXvo423hw6HGkgGW4VB6wuRzMNJ90GISmxlQfHInTfCe6v9hs0B
	 S3fk2J2JC82vh8hKsk0tW2YbnNLhgV8eJWG7PcgoKKGbVj8C8+JV1L+g+4CbHU04gr
	 MuldJFsj5M1IQ==
Date: Wed, 01 Jul 2026 10:54:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>, sophgo@lists.linux.dev, 
 Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jonathan Corbet <corbet@lwn.net>, Inochi Amaoto <inochiama@gmail.com>, 
 kvm@vger.kernel.org, spacemit@lists.linux.dev, 
 Jesse Taube <jtaubepe@redhat.com>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, linux-doc@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Anup Patel <anup@brainfault.org>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Chen Wang <chen.wang@linux.dev>, linux-kselftest@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>
To: Guodong Xu <docular.xu@gmail.com>
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>
Message-Id: <178292125218.626337.4829523300943840761.robh@kernel.org>
Subject: Re: [PATCH v5 08/17] dt-bindings: riscv: Require block-size for
 Zicbom, Zicbop, and Zicboz


On Wed, 01 Jul 2026 08:52:21 -0400, Guodong Xu wrote:
> Zicbom, Zicbop, and Zicboz have no default cache block size, so a
> devicetree that declares one must also provide the matching
> riscv,cbom/cbop/cboz-block-size property. Make it required so a
> missing block-size property can be caught by dtbs_check.
> 
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
> v5: New patch.
> ---
>  .../devicetree/bindings/riscv/extensions.yaml      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@0 (riscv): 'riscv,cbom-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@0 (riscv): 'riscv,cbop-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@0 (riscv): 'riscv,cboz-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@0 (riscv): Unevaluated properties are not allowed ('riscv,isa' was unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@1 (riscv): 'riscv,cbom-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@1 (riscv): 'riscv,cbop-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@1 (riscv): 'riscv,cboz-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@1 (riscv): Unevaluated properties are not allowed ('riscv,isa' was unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@10 (riscv): 'riscv,cbom-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@10 (riscv): 'riscv,cbop-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@10 (riscv): 'riscv,cboz-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@10 (riscv): Unevaluated properties are not allowed ('riscv,isa' was unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@11 (riscv): 'riscv,cbom-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@11 (riscv): 'riscv,cbop-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@11 (riscv): 'riscv,cboz-block-size' is a required property
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpu/idle-states.example.dtb: cpu@11 (riscv): Unevaluated properties are not allowed ('riscv,isa' was unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

