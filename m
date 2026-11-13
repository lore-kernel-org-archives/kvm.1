Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587001;
	b=D0tyyY3VBggjHmqPey97Wshg94WK9PRiPwd7dP5CoPozuiTa0vfjYz9sM9akLnGbfi2t
	 a99MUbPPoWnLPbX5kpqH3i9yiwVsOAf1MQIZ7JGiWu/ddRrJG6o2s2QOanSloJRGGGVFe
	 hzF2VB+FSML3Uc2gYoWedGfd8+RGk+MfRZs1Gf6DAE7yzNcvSCDYbqOjGin7JoH5EMjwK
	 0d4ih4Uv2dfB7m9ZuN7FP72JP/dbljCWl+m3WIiT8chLo39KITNaYgdcUaChsf5/MJ42e
	 Rnt7n3fGjWClPWmAuWSgBFH3Q+/oOnuuJ/DBwn12wT3KBf+BY6dw/pBbnNhYVKPHriw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w+7+IuN0u2dF5Xbb6zPkhJdEbCkTGj57A9p2AlEdZ74=;
	b=My3j5lWnmasVcDzdFMj2x2zuboSmAbaatb7YO7vLkpsWI5Kau/VVj1gftdGL4cbLGAnB
	 OBGRHGC/KMD1EWoXKIPC5VbQM4q3/rxhSBuSY0iPasoF4lGuoP1JkVS0b3+WO/S7qzf1z
	 4r1JhagGOMgYpKN89an5D+1v1UmJrO8wGMtx6wpfJu+eQVdyVXbUV+U68+p2KYtxzSxxm
	 jcnKgkrhaFIe9ZU2CwP7E37K49+FueMyoZuhXBcUHkPf8+mpBznWNI0PsXdrgq+psQxhc
	 VBDPuW9yivbOS8K487FbYS7EEF+U/tEczTYO3SxxJkT0/C2LWxEPKUp3gBjVu+i10PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkOVmx8P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4A606BA87
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkOVmx8P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC6E1F000C7;
	Fri, 13 Nov 2026 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587001;
	bh=w+7+IuN0u2dF5Xbb6zPkhJdEbCkTGj57A9p2AlEdZ74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkOVmx8PleEPPd9Pn0bvv7qjMKCiWfWPk7TJPhRgBbB/AfzfSSv6vxPLQmzy0ETGK
	 FD18y5pqctuXQzEJD6Aocd6zcTqvPE/Lv47AwMGH/8ztWiSAvW2J3sHG4qQCjBnf77
	 3mddLmto00E6OV9Z7yL+Grqhhh/zNADMlgzDZA3MhPSLasvsPjQiY4ixmAeWsfFxA5
	 bAYE3TyY8uO0pAJq7LXvNfyFIx1u1f0O0lhueoRUjNFO67+eNoSOPyJGpUjHln+7nL
	 l2CYaOAx5AFdJISXK8aRqcYp9S53GgelfkieRI/cNLWpP44LwsB5yta4tIyZTZOFJ9
	 /QsZzumFILYYw==
Message-ID: <sashiko-outbox-213188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 01/15] ctlv: Add the schema language and
 generator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-2-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-2-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:23:20 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Low] ctlv: compat: broken $include and shared field reconstruction in
  _foreign()
- [Low] ctlv: semantics: filled extension point accepted as normal
  record in _named()
- [Low] ctlv: semantics: order-dependent false record cycle error in
  _held()
- [Low] ctlv: spec: unresolved relative Path parent traversal in Paths
  and load()
- [Low] ctlv: semantics: single-pass _check_fills() misses nested
  extension sites
- [Low] ctlv: spec: _blob() accepts empty argument as valid backing list
- [Low] ctlv: missing composed size and fill depth checks in
  _check_composed()
--

commit c7763c8379c0de88c3274d5b9d07a09e53102368
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Add the schema language and generator

This commit adds the YAML meta-schemas for CTLV family specifications, the
family registry, and generated-file manifests, along with the ctlvgen tool
to validate specifications, check ABI compatibility, and emit UAPI and
kernel C files.

> diff --git a/tools/ctlv/ctlvgen/lib/compat.py b/tools/ctlv/ctlvgen/lib/co=
mpat.py
> new file mode 100644
> index 0000000000000..76bd14f60750b
> --- /dev/null
> +++ b/tools/ctlv/ctlvgen/lib/compat.py
[ ... ]
> +def _foreign(family: semantics.Family, record: semantics.Record,
> +             own: set[int]) -> dict[str, bool]:
> +    """What a record has that it does not declare: placed records and in=
cludes.
> +
> +    An include is one member, optional when it made a field optional tha=
t the
> +    record it splices requires.
> +    """
> +    members =3D {}
> +    for member in record.members:
> +        field =3D member.field
> +        if field.type in own:
> +            continue
> +        if field.shared:
> +            members[f'record {field.name}'] =3D member.required
> +            continue
> +        key =3D f'$include {field.record}'
> +        source =3D family.records[field.record]
> +        declared =3D any(item.required for item in source.members
> +                       if item.field.type =3D=3D field.type)
> +        members.setdefault(key, True)
> +        if declared and not member.required:
> +            members[key] =3D False
> +    return members

[Severity: Low]
Does reconstructing foreign members from the flattened record.members
corrupt ABI snapshots and trigger false ABI breaks?

Because _include() splices target.members directly into the including
record while keeping each field's original field.record and field.shared
values, if record A places a shared field f or includes record C and
record B has "$include: A", _foreign() records "record f" or "$include C"
in B's snapshot instead of "$include A".

In addition, _foreign() infers whether "$include X" was written with "?"
by checking if any field in X is required while its spliced member is
optional.  If a request record has "$include: X?" and the last required
field in X is later relaxed to optional, declared becomes False for every
field of X, so members['$include X'] flips from False to True and
_compare_members() reports a false "$include X became required" ABI break.

> diff --git a/tools/ctlv/ctlvgen/lib/semantics.py b/tools/ctlv/ctlvgen/lib=
/semantics.py
> new file mode 100644
> index 0000000000000..86725e7c1d693
> --- /dev/null
> +++ b/tools/ctlv/ctlvgen/lib/semantics.py
[ ... ]
> +    def _named(self, name: str, where: str | None) -> Record:
> +        """Return the named record or field of records: called name."""
> +        if name in self.named:
> +            return self.named[name]
> +        if name not in self.declared:
> +            if name in self.extensions:
> +                raise CtlvError(where, f'{name} is an extension point, w=
hich '
> +                                       'extension names')
> +            raise CtlvError(where, f'no record is called {name}')

[Severity: Low]
Can a filled extension point be referenced as a normal named record via
"record <name>" or "$include: <name>"?

When a descendant family fills an inherited extension point in records:,
_add_records() adds that name to self.declared and self.named.  Because
_named() only checks self.extensions when name is absent from self.named
and self.declared, referencing the extension point via "record <name>" or
"$include: <name>" in the filling family or a further descendant bypasses
the self.extensions check and treats the fill as a regular reusable
record.

> +        if name in self.building:
> +            raise CtlvError(where, 'record cycle: ' +
> +                                   ' -> '.join(self.building + (name,)))
[ ... ]
> +    def _held(self, name: str, where: str) -> str:
> +        """Return the path of the named record a field holds."""
> +        self.used.add(name)
> +        if name in self.building:
> +            # A record holding itself, which the tree re-enters.
> +            is_field =3D self.declared[name][3].body is None
> +        else:
> +            is_field =3D self._named(name, where).role =3D=3D 'field'
> +        if is_field:
> +            raise CtlvError(where, f'record {name} holds a named record,=
 and '
> +                                   f'{name} is a field of records:, whic=
h '
> +                                   'bare record places')
> +        return name

[Severity: Low]
Does _held() raise an order-dependent false "record cycle" error when a
held record includes the enclosing record?

If record A has a field "b?: record B" and record B has "$include: A",
declaring B before A succeeds because _held('B') sees 'B' in
self.building and inspects self.declared['B'][3].body directly.  If A is
declared before B, _named('A') calls _held('B') while 'A' is in
self.building, and _held('B') calls _named('B'), which resolves
"$include: A" and fails with "record cycle: A -> B -> A".  Checking
self.declared[name][3].body whenever name is in self.declared avoids
resolving B while A is still being built.

[ ... ]

> +    def _check_fills(self, fills: tuple[Fill, ...]) -> None:
> +        """Hold each fill to every place its extension point sits.
> +
> +        A fill nested in another is met after it, so its places are know=
n.
> +        """
> +        for fill in fills:
> +            where =3D self.declared[fill.name][1]
> +            for site, context, level in self.sites.get(fill.name, []):
> +                self._check_subtree(f'{where} in {site}', fill.root, con=
text,
> +                                    level)

[Severity: Low]
Can a single pass in _check_fills() miss extension sites when a later fill
reuses a record containing an earlier-filled extension point?

 If an ancestor family declares extension point ext-b inside a named record
rec-b and extension point ext-a in an op, and a descendant fills ext-b
before ext-a (either earlier in records: or in an intermediate parent
family) while filling ext-a using rec-b, ext-b precedes ext-a in fills.
_check_fills() then checks ext-b before visiting ext-a, so the site for
ext-b inside ext-a is appended to self.sites['ext-b'] after ext-b's loop
has already finished, skipping context and depth validation for ext-b at
that site.

[ ... ]

> +def _check_composed(family: Family) -> None:
> +    def walk_composed(where: str, node: Node) -> int:
> +        members =3D composed_members(family, node)
> +        required =3D sum(not optional for _child, optional in members)
> +        optional =3D len(members) - required
> +
> +        _check_count(where, 'composed required fields', required,
> +                     spec.U32_MAX)
> +        _check_count(where, 'composed optional fields', optional,
> +                     spec.U32_MAX)
> +        count =3D 1
> +        for child, _optional in members:
> +            count +=3D walk_composed(where, child)
> +        return count
> +
> +    for op in family.ops:
> +        total =3D 0
> +        for which, root in (('request', op.request), ('reply', op.reply)=
):
> +            if root is None:
> +                continue
> +            where =3D f'{family.path}: op {op.name} {which}'
> +            count =3D walk_composed(where, root)
> +            _check_count(where, 'composed schema nodes', count,
> +                         spec.U32_MAX)
> +            total +=3D count
> +        _check_count(f'{family.path}: op {op.name}',
> +                     'composed request and reply nodes', total,
> +                     spec.U32_MAX)

[Severity: Low]
Does _check_composed() miss checking composed op message sizes against
MAX_INLINE_MESSAGE_LEN?

_add_ops() runs sizes.compute() on the uncomposed op tree where extension
points are empty, while sizes.composed() in tools/ctlv/ctlvgen/lib/sizes.py
is never called here.  Even after commit "tools/ctlv: Add the userspace
library" calls sizes.composed() in gen_user.py, running ctlvgen with
--validate or --mode kernel (or reconciling manifests without optional
user-source outputs) will not reject extension fills that push an
inherited op's composed request, action reply, or minimum query reply
length past MAX_INLINE_MESSAGE_LEN.

Similarly, in tools/ctlv/ctlvgen/lib/gen_kernel.py:_limits(), returning
early when family.local_ops is empty skips emitting the
CTLV_MAX_DECLARED_RECORD_DEPTH static_assert for family.fills on
descendant families that only fill inherited extension points.

> diff --git a/tools/ctlv/ctlvgen/lib/spec.py b/tools/ctlv/ctlvgen/lib/spec=
.py
> new file mode 100644
> index 0000000000000..7d1f2e14f70fd
> --- /dev/null
> +++ b/tools/ctlv/ctlvgen/lib/spec.py
[ ... ]
> +class Paths:
> +    """Where the specs, the registry and the meta-schemas are."""
> +
> +    def __init__(self, spec: pathlib.Path | str,
> +                 schema: pathlib.Path | str | None =3D None,
> +                 registry: pathlib.Path | str | None =3D None,
> +                 abi: pathlib.Path | str | None =3D None) -> None:
> +        self.spec =3D pathlib.Path(spec)
> +        self.spec_dir =3D self.spec.parent
> +        self.doc_dir =3D self.spec.parent.parent
> +        self.schema =3D pathlib.Path(schema or self.doc_dir / 'ctlv-sche=
ma.yaml')
> +        self.registry =3D pathlib.Path(registry or
> +                                     self.doc_dir / 'families.yaml')
> +        # The two meta-schemas ship together, so overriding one locates =
both.
> +        self.registry_schema =3D (self.schema.parent /
> +                                'ctlv-registry-schema.yaml')
> +        self.abi_dir =3D pathlib.Path(abi or self.doc_dir / 'abi')
> +        self.registry_abi =3D self.abi_dir / 'families.registry.yaml'
> +        self.generated =3D self.doc_dir / 'generated-files.yaml'
> +        self.generated_schema =3D self.doc_dir / 'generated-files-schema=
.yaml'
> +        self.kernel_dir =3D self.schema.parent.parent.parent
[ ... ]
> +def load(path: pathlib.Path | str, schema: pathlib.Path) -> FamilySpec:
> +    """Load, syntax-check and normalize one family specification."""
> +    path =3D pathlib.Path(path)
> +    data, lines =3D yamlload.load_with_lines(path)
> +    _validate_syntax(path, data, schema)
> +
> +    reader =3D _Reader(path, lines,
> +                     pathlib.Path(schema).parent.parent.parent / UAPI_DI=
R)

[Severity: Low]
Does traversing .parent on unresolved relative Path objects in
Paths.__init__() and load() misresolve kernel_dir and the UAPI directory?

In pathlib, taking .parent on a relative path strips components until it
reaches Path('.'), where .parent stays Path('.').  If ctlvgen is invoked
from Documentation/ctlv/ with "--spec specs/ctlv.yaml --validate",
self.schema is Path('ctlv-schema.yaml') and self.schema.parent.parent.parent
collapses to Path('.') instead of the kernel tree root, mislocating both
self.kernel_dir and include/uapi.  Resolving the paths first (or using
os.path.abspath) avoids this.

[ ... ]

> +    def _blob(self, where: str, args: str) -> BlobDecl:
> +        parts =3D _arguments(args) if args is not None else ['']
> +        direction =3D DIRECTIONS.get(parts[0])
> +        if direction is None:
> +            raise CtlvError(where, 'a blob starts with its direction, in=
, '
> +                                   'out or inout')
> +        maximum, alignment, backings =3D None, None, None
> +        for arg in parts[1:]:
> +            aligned =3D _ALIGN.fullmatch(arg)
> +            if arg.startswith('..') and maximum is None:
> +                maximum =3D self._size(where, arg[2:].strip(), 'blob len=
gth',
> +                                     U64_MAX)
> +            elif aligned is not None and alignment is None:
> +                alignment =3D self._size(where, aligned['value'],
> +                                       'blob alignment')
> +            elif backings is None and all(word in BACKINGS
> +                                          for word in arg.split()):
> +                backings =3D tuple(arg.split())

[Severity: Low]
Does _blob() silently accept an empty comma-separated argument such as
"blob(in, )"?

When arg is empty, arg.split() is [], so all(word in BACKINGS for word in
arg.split()) evaluates to True and sets backings =3D (), which is then
replaced by DEFAULT_BACKINGS via "backings or DEFAULT_BACKINGS".  Checking
that arg.split() is non-empty would reject malformed empty arguments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D1
