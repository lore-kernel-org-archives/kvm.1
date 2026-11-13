Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586381;
	b=VcWIEyaSsoffPHkjJp/yD/IakpSunRSSxXZYEKsTG9rvWbzeLkjKGi5HQzocPA/ESg+a
	 RjqyOw3j7zsT02XiKEm35k1iq1AAUSglUFRQVTeKwxGqNn4k4/T9xDViY9CEOgIth6q78
	 i/AKq45suGmGTqDaXOOnBeekmK0awREQ7trJDKaAEDP9wiipvDv42ksC++HaGKOmLtxpF
	 13zuRGalXUDsIJGj07u+5FgS0ID2mX8opQ7WVnI9U04i3yUbnRq4s96l7SRfMG2OGgGFy
	 I6ECqC1jM5NfumbRiFNUZ8hM0vrAQ8mWXiGFGEIRYSrRTENoA7gj4QLwL0o9ZgjIL0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+w3wc6tkKcO8bk94IBPGtLICnhkjKw536W7deGlPuCA=;
	b=A9TfPMt02wcc8+Xzhuz02YB/YBwfenolQU6GIKBZJEYOJQia2HlHPfmJR4a11FVC/YUB
	 7e42A6oA1ypXr1xRLJc4ZsO5Rm6D2dDzWLTEySHNPw0x1J2XfuwI6PXjesRzwFn+htNgO
	 971x2PtkOWrqmfTUhGgtV1eNRjEBPFayi0yc2P6Q/JV4iZkIpLQ8mFWpD3Fx84Y2W6GHh
	 LNhxRN9Z4Wtt8hQwjkYsKJmzVq5ski2G1YJe5GMeHz9SPMV0EA18BKq2gl+L/gqbyy2ZM
	 e/X2AkUUlJDox+WO1vtqp19zn9QLYUO0Tg6beeVf+/cA8Rzn1qI5lDjkqyjq1wlnuNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FApX9Abv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C80606A891
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FApX9Abv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258C31F000C5;
	Fri, 13 Nov 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586381;
	bh=+w3wc6tkKcO8bk94IBPGtLICnhkjKw536W7deGlPuCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FApX9AbvfDqV+tiWWASYd8NZ7raT6a2cI8GUbjrzO45OKEbiX1JtemgU4+zM3Lcbd
	 9p9EOWAZs8cRyzv6dxsIDwPD/R8aM7ZYuOH5aIp7zisUOvYGB+bKtpB40pm/wOVgjO
	 mcGOsMvAhZQ4/4xfmwNaz32pwbS01onYavSZY2A1duFfFVBHSmgOud7FoQIRH3hdDh
	 /0om83oaA93hfsqmtmKDdmFo9vr8T7jO+qJ58JyAmUydams8lDyg1HBp4h1nEWoHKr
	 5kCz1yg8zZXptoHsJWu5+WWmfA7k/lnhgH8Fxf9BluMXB2/Y0kOMXsF1ep0dTPKNtQ
	 5fnfAjol3KUXg==
Message-ID: <sashiko-outbox-213174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 13/15] Documentation: ctlv: Describe how to write
 a family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-14-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-14-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:13:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] docs: ctlv: direct -ESTALE return in query example skips
  error-info
- [Low] docs: ctlv: inaccurate claim that unfilled extension adds no
  record
--

commit 37d8b6224a7e92519379e383dd7fb525d99c7126
Author: Jiri Pirko <jiri@resnulli.us>

Documentation: ctlv: Describe how to write a family

This commit adds driver-api documentation explaining how to define a CTLV
family specification in YAML and implement its kernel callbacks.

> diff --git a/Documentation/driver-api/ctlv.rst b/Documentation/driver-api=
/ctlv.rst
> new file mode 100644
> index 0000000000000..34d20c14a9bfa
> --- /dev/null
> +++ b/Documentation/driver-api/ctlv.rst
> @@ -0,0 +1,716 @@

[ ... ]

> +    int ctlv_example_item_get_query(struct ctlv *ctlv,
> +                                      struct ctlv_op_ctx *ctx,
> +                                      const struct ctlv_cursor *request,
> +                                      struct ctlv_cursor *reply)
> +    {
> +            struct example_device *example =3D to_example(ctlv);
> +            u64 generation =3D READ_ONCE(example->generation);
> +            u64 cursor =3D ctlv_op_query_cursor(ctx);
> +            struct ctlv_cursor item;
> +            u64 i =3D cursor ? cursor - 1 : 0;
> +
> +            if (cursor && ctlv_op_query_generation(ctx) !=3D generation)
> +                    return -ESTALE;

[Severity: Low]
Does returning -ESTALE directly here skip populating ctx->error for
ctlv_error_info()?

ctlv_query_fragment_end() (called by ctlv_op_query_done() and
ctlv_op_query_more()) is the only place that sets
CTLV_VALIDATION_REASON_STALE_GENERATION along with expected_generation and
current_generation:

lib/ctlv/builder.c:ctlv_query_fragment_end() {
    ...
	if (ctx->frag.cursor && generation !=3D ctx->frag.generation) {
		ctx->error.reason =3D CTLV_VALIDATION_REASON_STALE_GENERATION;
		ctx->error.expected_generation =3D ctx->frag.generation;
		ctx->error.current_generation =3D generation;
		return -ESTALE;
	}
    ...
}

When a callback returns -ESTALE directly, ctlv_error_info() sees
ctx->error.reason =3D=3D 0 and omits the stale-generation error-info message
documented in Documentation/userspace-api/ctlv.rst.  Calling
ctlv_op_query_done(ctx, generation) on mismatch or letting the loop finish
into ctlv_op_query_done() would populate the error info and return
-ESTALE.

[ ... ]

> +The ``device-get`` callback in ``ctlv-example`` opens the record and has=
 the
> +device's family fill it:
> +
> +.. code-block:: c
> +
> +    if (ctlv_example_device_get_details_start(reply, &details)) {
> +            ret =3D ctlv_ext_fill(ctx, NULL, &details);
> +            ctlv_record_end(&details);
> +            if (ret)
> +                    return ret;
> +    }
> +
> +The foo family implements the generated fill callback:
> +
> +.. code-block:: c
> +
> +    int ctlv_example_foo_device_details_fill(struct ctlv *ctlv,
> +                                             struct ctlv_op_ctx *ctx,
> +                                             const struct ctlv_cursor *r=
equest,
> +                                             struct ctlv_cursor *record)
> +    {
> +            struct foo_device *foo =3D container_of(ctlv, struct foo_dev=
ice,
> +                                                  example.ctlv);
> +
> +            ctlv_example_foo_device_details_sram_bank_put(record,
> +                                                          foo->sram_bank=
);
> +            return 0;
> +    }
> +
> +``request`` is the matching record of the request, for an op whose reque=
st has
> +an extension point too; ``device-get`` has none and passes ``NULL``. An
> +extension point no family fills adds no record and no length.

[Severity: Low]
Is it accurate that an unfilled extension point adds no record and no
length?

ctlv_example_device_get_details_start() calls ctlv_record_start(), which
writes a 16-byte struct ctlv_hdr with CTLV_HDR_F_RECORD into the reply and
adds 16 bytes to each ancestor record's length.  When no family in the
chain fills the extension point, ctlv_ext_fill() returns 0 and
ctlv_record_end() leaves that empty 16-byte record in the output buffer
(and the schema size calculations in schema.c and sizes.py likewise count
16 bytes for the empty extension record header).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D13
